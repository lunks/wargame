require 'spec_helper'

describe FacilityFleet do
  it {should belong_to :producing_unit}
  it {should belong_to :producing_unit2}
  it {should belong_to :destination}
  let(:facility_fleet) {Factory :facility_fleet}
  let(:facility) {facility_fleet.facility}
  let(:unit) {Factory :unit}
  let(:squad) {Factory :squad}
  let(:planet) {Factory :planet}

  it 'should be a fleet' do
    facility_fleet.should be_an_instance_of FacilityFleet
    facility_fleet.should be_a_kind_of GenericFleet
  end

  it 'should have a facility balance' do
    facility_fleet.balance = 1000
    facility_fleet.balance.should == 1000
  end

  it 'should pick producing unit' do
    facility_fleet.producing_unit = unit
    facility_fleet.producing_unit.should be_an_instance_of Unit
  end

  it 'should pick a second producing unit' do
    facility_fleet.producing_unit2 = unit
    facility_fleet.producing_unit2.should be_an_instance_of Unit
  end

  it 'should start with level 0' do
    facility_fleet.level = 0
    facility_fleet.save
    facility_fleet.level.should be 0
  end
  it 'should increase level' do
      2.times {facility_fleet.upgrade!}
      facility_fleet.level.should == 2   
  end
  
  it 'should flag as sabotaged' do
    facility_fleet.sabotage!
    facility_fleet.sabotaged.should be_true
  end

  context 'moving' do
    before do
      facility_fleet.squad = squad
      facility_fleet.balance = 1000
      facility_fleet.level = 1
      facility_fleet.save
      @moving_fleet = facility_fleet.move planet
    end

    context 'setting to move' do
      it 'should be flagged as a moving unit when moving' do
        @moving_fleet.should be_moving
      end
      it 'should have a destination planet when moving' do
        @moving_fleet.destination.should == planet
      end
      it 'should change display name when moving' do
        @moving_fleet.name.should_not == facility_fleet.facility.name
        @moving_fleet.name.should == facility_fleet.facility.description
      end
    end

    context 'finishing movement' do
      before(:each) do
        @moving_fleet.move!
      end
      it 'should effect moving orders' do
        @moving_fleet.should be_moving
        @moving_fleet.destination.should == planet
        @moving_fleet.planet.should == planet
      end
      it 'should be unflagged as a moving unit' do
        @moving_fleet.reassembly
        @moving_fleet.should_not be_moving
      end
      it 'should reset its balance and level' do
        @moving_fleet.reassembly
        @moving_fleet.balance.should == 0
        @moving_fleet.level.should == 0
      end
    end

  end

  context 'related to fleeing fleet' do
    let(:unit) {Factory :facility_fleet, :squad => squad}
    before(:each) do
      @origin = Factory(:planet)
      @destination = Factory(:planet)
      unit.planet = @origin
      @route1 = Factory :route, :vector_a => @origin, :vector_b => @destination
    end

    it 'should go to an adjacent planet' do
      fleeing_fleet = unit.flee! 1
      fleeing_fleet.planet.should_not == @origin
      fleeing_fleet.planet.should == @destination
    end

  end
    
  context 'on every new turn' do
    let(:facility) {facility_fleet.facility}
    before(:each) do
      Fleet.destroy_all
      facility.price = 7500
      unit.price = 300
      facility_fleet.producing_unit = unit
      facility_fleet.planet = Factory :planet
      facility_fleet.level = 0
      facility_fleet.save!
    end
    it 'should set its balance on every new turn' do
      facility_fleet.producing_unit = nil
      facility_fleet.produce!
      facility_fleet.balance.should == facility.price/3
    end
    it 'should produce fleet if we have enough credits' do
      facility_fleet.produce!
      Fleet.count.should be 1
    end
    it 'should not produce a fleet if we dont have enough credits' do
      facility_fleet.produce!
      facility_fleet.producing_unit.price = 9000
      facility_fleet.save
      Fleet.count.should be 1
    end
    it 'should create a correct number of units according to balance' do
      facility_fleet.producing_unit.price = 500
      facility_fleet.produce!
      Fleet.first.quantity.should == 5
    end
    it 'should produce 500 more when upgraded' do
      facility_fleet.producing_unit = nil
      facility_fleet.upgrade!
      facility_fleet.produce!
      facility_fleet.balance.should == facility.price/3 + 500
    end
    it 'should debit squad credits for upgrade' do
      squad = Factory(:squad, :credits => 10000)
      upgrade_costs = 1500
      facility_fleet.squad = squad
      facility_fleet.save!
      facility_fleet.upgrade!
      squad.credits.should == 10000 - upgrade_costs
    end

    it 'should produce 50% less when sabotaged or blocked' do
      facility_fleet.producing_unit = nil
      facility_fleet.save
      facility_fleet.sabotage!
      facility_fleet.produce!
      facility_fleet.balance.should == (facility.price / 3) * 0.50
    end
    it 'should not produce if moving' do
      facility_fleet.moving = true
      facility_fleet.save
      facility_fleet.produce!
      Fleet.count.should be 0
    end
    it 'should not produce if facility planet is a tradeport station' do   
      facility_fleet.planet.tradeport = true
      facility_fleet.save
      facility_fleet.produce!
      Fleet.count.should be 0
    end
    it 'should produce max 10 warriors lives and left over balance' do
      facility_fleet.producing_unit = Factory(:warrior, :price => 10)
      facility_fleet.save
      facility_fleet.produce!
      Fleet.last.quantity.should == 10
      facility_fleet.balance.should == ( facility.price / 3 ) - 100
    end
    it 'should produce max 1 commander life and left over balance' do
      facility_fleet.producing_unit = Factory(:commander, :price => 100)
      facility_fleet.save
      facility_fleet.produce!
      Fleet.last.quantity.should == 1
      facility_fleet.balance.should == ( facility.price / 3 ) - 100
    end

  end

  context 'Training Jedi Warriors' do
  let (:warrior) {Factory :warrior}
    before(:each) do
      facility.price = 3000
      facility_fleet.producing_unit = warrior
      facility_fleet.planet = Factory :planet
      facility_fleet.save!
      facility_fleet.produce!
    end
    
    it 'should training an unique warrior' do
      facility_fleet.planet = Factory :planet
      facility_fleet.save!
      facility_fleet.produce!
      Fleet.where(:generic_unit => warrior).count.should == 1
    end

    it 'should prevent warriors have more than 10 lives' do
      facility_fleet.produce!
      warrior_fleet = Fleet.where(:generic_unit => warrior)
      warrior_fleet.first.quantity.should == 10
    end
  end

  context 'Training Commanders' do
  let (:commander) {Factory :commander}
    before(:each) do
      facility.price = 3000
      facility_fleet.producing_unit = commander
      facility_fleet.planet = Factory :planet
      facility_fleet.save!
      facility_fleet.produce!
    end
    
    it 'should training an unique commander' do
      facility_fleet.planet = Factory :planet
      facility_fleet.save!
      facility_fleet.produce!
      Fleet.where(:generic_unit => commander).count.should == 1
    end

    it 'should prevent commanders have more than 1 life' do
      facility_fleet.produce!
      warrior_fleet = Fleet.where(:generic_unit => commander)
      warrior_fleet.first.quantity.should == 1
    end
  end

end
