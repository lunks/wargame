require 'spec_helper'

describe Fleet do

  it {should belong_to :destination}
  it {should belong_to :generic_unit}

  let(:unit) {Factory :fleet}

  context 'moving and attacking' do
    let(:planet) {Factory :planet}
    it 'should be flagged as a moving unit when moving' do
      unit.move 1, planet
      unit.should be_moving
    end

    it 'should have a destination planet when moving' do
      unit.move 1, planet
      unit.destination.should == planet
    end
  end

  

end

