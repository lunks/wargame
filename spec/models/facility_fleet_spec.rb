require 'spec_helper'

describe FacilityFleet do
  it {should belong_to :producing_unit}
  let(:facility_fleet) {Factory :facility_fleet}
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
  context 'on every new turn' do
    let(:facility) {facility_fleet.facility}
    before(:each) do
      facility.price = 7500
      unit.price = 300
      facility_fleet.producing_unit = unit
      facility_fleet.planet = Factory :planet
      facility_fleet.save!
    end
    it 'should set its balance on every new turn' do
      facility_fleet.producing_unit = nil
      facility_fleet.produce!
      facility_fleet.balance.should == facility.price/5
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
      facility_fleet.balance = 7500
      facility_fleet.producing_unit.price = 1500
      facility_fleet.produce!
      Fleet.first.quantity.should == 5
    end
  end

end
