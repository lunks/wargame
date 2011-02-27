require 'spec_helper'

describe Fleet do
  it {should belong_to :squad}
  it {should belong_to :planet}
  it {should belong_to :unit}
  it {should belong_to :destination}

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

  context 'capturing units' do
    let(:fleet) {Factory :fleet}
    it 'should change units to another squad' do
      fleet.capture squad
      fleet.should be_captured
    end

  end


end

