require 'spec_helper'

describe OwnedShip do
  it {should belong_to :squad}
  it {should belong_to :planet}
  it {should belong_to :ship}
  it {should belong_to :destination}

  let(:ship) {Factory :owned_ship}

  context 'moving and attacking' do
    let(:planet) {Factory :planet}
    it 'should be flagged as a moving ship when moving' do
      ship.move 1, planet
      ship.should be_moving
    end

    it 'should have a destination planet when moving' do
      ship.move 1, planet
      ship.destination.should == planet
    end
  end
end

