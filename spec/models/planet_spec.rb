require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :generic_fleets}

  it 'should output its profits if they have a capital ship on it fleets' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0
    fleet = Factory :generic_fleet
    unit = Factory :capital_ship
    fleet.generic_unit = unit
    planet.generic_fleets << fleet
    planet.credits_per_turn.should be 1000
  end



  context 'changing ownership of the planet' do
    before(:each) do
      @squad = Factory :squad
      planet.squad = @squad
    end
    it 'should remove its ownership if it doesnt have a capital ship on it' do
      planet.set_ownership
      planet.squad.should be_nil
    end

    it 'should change its ownership if it has a capital ship on it' do
      fleet = Factory :generic_fleet
      fleet.squad = @squad
      fleet.generic_unit = Factory :capital_ship
      planet.generic_fleets << fleet
      planet.set_ownership
      planet.squad.should be @squad
    end
  end
  it 'should get a random planet' do
    3.times {Factory :planet}
    Planet.randomize.should be_an_instance_of Planet
  end
end

