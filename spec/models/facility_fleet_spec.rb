require 'spec_helper'

describe FacilityFleet do
  it {should belong_to :producing_unit}
  let(:facility_fleet) {Factory :facility_fleet}

  it 'should be a fleet' do
    facility_fleet.should be_an_instance_of FacilityFleet
    facility_fleet.should be_a_kind_of GenericFleet
  end

  it 'should have a facility balance' do
    facility_fleet.balance = 1000
    facility_fleet.balance.should be 1000
  end

  it 'should pick producing unit' do
    unit = Factory :unit 
    facility_fleet.producing_unit = unit
    facility_fleet.producing_unit.should be_an_instance_of Unit
   
  end
 

end
