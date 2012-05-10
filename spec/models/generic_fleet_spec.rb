require 'spec_helper'

describe GenericFleet do

  it {should belong_to :squad}
  it {should belong_to :planet}

  let(:unit) {Factory :generic_fleet}
  let(:trooper) {Factory :trooper}
  let(:capital_ship) {Factory :capital_ship}
  let(:facility_unit) {Factory :facility_fleet}
  let(:facility) {Factory :facility}

  context 'blast units' do
    before(:each) do
      unit.quantity = 1
    end
    it 'should remove units from the current fleet' do
      unit.blast! 1
      unit.quantity.should be 0
    end
  end


  context 'capturing units' do
    let(:squad) {Factory :squad}
    before(:each) do
      unit.quantity = 1
    end

    it 'should remove units from the current fleet' do
      unit.capture! 1, squad
      unit.quantity.should be 0
    end

    it 'should remove fleet if quantity equals zero' do
      unit.capture! 1, squad
      unit.should be_new_record
    end

    it 'should transfer fleet to another squad' do
      unit.capture! 1, squad
      squad.generic_fleets.count.should be 1
    end

    context 'related to captured fleet' do
      before(:each) do
        unit.capture! 1, squad
      end
      let(:captured_unit) {squad.generic_fleets.first}

      it 'should have the captured quantity' do
        captured_unit.quantity.should be 1
      end
    end

    context 'related to captured facility fleet' do

      it 'should reset balance when captured' do
        facility_unit.balance = 100
        facility_unit.producing_unit = capital_ship
        facility_unit.save
        facility_unit.capture! 1,squad
        captured_facility = squad.generic_fleets.first
        capacity = captured_facility.generic_unit.price / 4
        captured_facility.balance.should == capacity - capacity * 2
      end

    end

  end

end

