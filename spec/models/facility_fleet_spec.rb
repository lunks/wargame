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

  it 'should start with level 0' do
    facility_fleet.level = 0
    facility_fleet.level.should be 0
  end
  
  it 'should flag as sabotaged' do
    facility_fleet.sabotage!
    facility_fleet.sabotaged.should be_true
  end

  context 'moving' do
    before do
      facility_fleet.squad = squad
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
        @merging_fleet = Factory :facility_fleet, :planet => planet, :generic_unit => facility_fleet.generic_unit, :squad => facility_fleet.squad, :fleet_name => facility_fleet.squad.name
        @moving_quantity = @moving_fleet.quantity
        @moving_fleet.move!
      end
      it 'should effect moving orders' do
        @moving_fleet.should be_moving
        @moving_fleet.planet.should == planet
      end
    end

    context 'reassembling facility' do
      it 'should be unflagged as a moving unit' do
        @moving_fleet.reassembly
        @moving_fleet.should_not be_moving
      end
    end

  end
    


  context 'on every new turn' do
    let(:facility) {facility_fleet.facility}
    before(:each) do
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
      Fleet.count.should be 1
    end
    it 'should create a correct number of units according to balance' do
      facility_fleet.producing_unit.price = 500
      facility_fleet.produce!
      Fleet.first.quantity.should == 5
    end
    it 'should increase level' do
      2.times {facility_fleet.upgrade!}
      facility_fleet.level.should == 2   
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
    it 'should produce 50% less when sabotaged' do
      facility_fleet.producing_unit = nil
      facility_fleet.save
      facility_fleet.sabotage!
      facility_fleet.produce!
      facility_fleet.balance.should == (facility.price / 3) * 0.50
  end
    it 'should decrease level' do
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

end
