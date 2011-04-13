require 'spec_helper'

describe Planet do
  let(:planet) {Factory :planet}

  it {should belong_to :squad}
  it {should have_many :generic_fleets}
  it {should belong_to :ground_squad}

  it 'should output its profits if the squad has air and ground ownership' do
    planet.credits = 1000
    planet.credits_per_turn.should be 0

    squad = Factory :squad
    capital_ship = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:capital_ship)
    trooper = Factory :generic_fleet, :squad => squad, :generic_unit => Factory(:trooper)

    planet.generic_fleets << capital_ship
    planet.generic_fleets << trooper

    planet.set_ownership
    planet.set_ground_ownership
    planet.credits_per_turn.should be 1000
  end
  context 'regarding partial and full ownerships' do
    before(:each) do
      @squad = Factory :squad
      planet.squad = @squad
    end
    it 'should remove its ownership if it doesnt have a capital ship on it' do
      planet.set_ownership
      planet.squad.should be_nil
    end
    it 'should remove its ground ownership if it doesnt have a trooper on it' do
      planet.set_ground_ownership
      planet.ground_squad.should be_nil
    end
    context 'air ownership' do
      let(:capital_ship) {Factory :generic_fleet, :squad => @squad, :generic_unit => Factory(:capital_ship)}
      let(:facility) {Factory :generic_fleet, :squad => @squad, :generic_unit => Factory(:facility)}

      it 'should change its owner if it has a capital ship' do
        planet.generic_fleets << capital_ship
        planet.set_ownership
        planet.squad.should be @squad
      end

      it 'should change its ownership if it has a facility on it' do
        planet.generic_fleets << facility
        planet.set_ownership
        planet.squad.should be @squad
      end
    end

    context 'ground ownership' do
      let(:trooper) {Factory :generic_fleet, :squad => @squad, :generic_unit => Factory(:trooper)}

      it 'should change its owner if planet has a trooper on it' do
        planet.generic_fleets << trooper
        planet.set_ground_ownership
        planet.ground_squad.should be @squad
      end
    end
  end

  it 'should get a random planet' do
    3.times {Factory :planet}
    Planet.randomize.should be_an_instance_of Planet
  end
  it 'should find planets adjacent of it' do
    second_planet = Factory :planet
    Factory :route, :vector_a => planet, :vector_b => second_planet
    planet.routes.should include(second_planet)
  end
end
