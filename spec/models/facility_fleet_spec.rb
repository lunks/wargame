require 'spec_helper'

describe FacilityFleet do
  it {should belong_to :producing_unit}
  let(:facility_fleet) {Factory :facility_fleet}
  let(:facility) {facility_fleet.facility}
  let(:unit) {Factory :unit}
  it 'should be a fleet' do
    facility_fleet.should be_an_instance_of FacilityFleet
    facility_fleet.should be_a_kind_of GenericFleet
  end

  it 'should have a facility balance' do
    facility_fleet.balance = 1000
    facility_fleet.balance.should be 1000
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
