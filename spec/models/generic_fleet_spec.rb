require 'spec_helper'

describe GenericFleet do

  it {should belong_to :squad}
  it {should belong_to :planet}

  let(:unit) {Factory :generic_fleet}

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
  end


end

