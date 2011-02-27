require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :fleets}

  it 'should output its profits based on the ship they have on it' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0
    ship = Factory :fleet
    planet.fleets << ship
    planet.credits_per_turn.should be 1000

  end

end

