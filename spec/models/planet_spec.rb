require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :generic_fleets}
  it {should belong_to :ground_squad_id}

  it 'should output its profits if the squad has air and ground ownership' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0

    squad = Factory :squad

    fleet1 = Factory :generic_fleet
    unit1 = Factory :capital_ship
    fleet1.squad = squad
    fleet1.generic_unit = unit1
    planet.generic_fleets << fleet1

    fleet2 = Factory :generic_fleet
    unit2 = Factory :trooper
    fleet2.squad = squad
    fleet2.generic_unit = unit2
    planet.generic_fleets << fleet2

    planet.set_ownership
    planet.set_ground_ownership    
    planet.credits_per_turn.should be 1000

  end

  context 'changing air and ground ownership of the planet' do
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

    it 'should remove its ground ownership if it doesnt have a trooper on it' do
      planet.set_ground_ownership
      planet.ground_squad_id.should be_nil
    end

    it 'should change its ground ownership if it has a troopers on it' do
      fleet = Factory :generic_fleet
      fleet.squad = @squad
      fleet.generic_unit = Factory :trooper
      planet.generic_fleets << fleet
      planet.set_ground_ownership
      planet.ground_squad_id.should be @squad
    end


  end

  it 'should get a random planet' do
    3.times {Factory :planet}
    Planet.randomize.should be_an_instance_of Planet
  end
end

