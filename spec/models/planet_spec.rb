require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :generic_fleets}

  it 'should output its profits based on the ship they have on it fleets cost more than 1000' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0
    fleet = Factory :generic_fleet
    fleet.generic_unit.price = 20
    planet.generic_fleets << fleet
    planet.credits_per_turn.should be 0
    fleet.generic_unit.price = 2000
    planet.credits_per_turn.should be 1000
  end
  context 'changing ownership of the planet' do
    before(:each) do
      @squad = Factory :squad
      planet.squad = @squad
    end
    it 'should remove its ownership if fleets dont worth enough' do
      planet.set_ownership
      planet.squad.should be_nil
    end
    it 'should change its ownership if fleets have enough value' do
      fleet = Factory :generic_fleet
      fleet.squad = @squad
      fleet.generic_unit.price = 2000
      planet.generic_fleets << fleet
      planet.set_ownership
      planet.squad.should be @squad
    end
  end
end

