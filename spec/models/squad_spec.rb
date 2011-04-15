require 'spec_helper'

describe Squad do
  let(:squad) {Factory :squad}
  it {should have_many :planets}
  it {should have_many :generic_fleets}
  context 'buying and selling facilities' do
    let(:facility) {Factory :facility, :price => 1000}
    let(:planet) {Factory :planet}
    before(:each) do
      facility.factions = squad.faction
    end
    context 'buying facilities' do
      it 'should be able to buy facilities and remove credits accordingly' do
        squad.credits = 2000
        squad.buy facility, 2, planet
        squad.credits.should be 0
      end

      it 'should not be able to buy a facility they dont have access to' do
        facility.factions = 'rebel'
        squad.buy(facility, 1, planet).should be_false
      end

      it 'should not buy a ship that is not a facility' do
        squad.buy(facility, 1, planet).should be_true
        normal_unit = Factory :unit
        squad.buy(normal_unit, 1, planet).should be_false
      end

      it 'should be able to buy a facility they have access to' do
        squad.buy(facility, 1, planet).should be_true
      end

      it 'should add the facility to the list of Fleets' do
        squad.buy facility, 1, planet
        squad.generic_fleets.should_not be_empty
      end

      it 'should be able buy facilities and send them specifically to a planet' do
        squad.buy facility, 1, planet
        squad.generic_fleets.first.planet.should == planet
      end
    end
    context 'aggregating profits' do
      let(:planet) {Factory :planet}
      before(:each) do
        planet.save
        planet.credits = 1000
        squad.planets << planet
        squad.credits = 0
        squad.save
      end

      it 'should generate profits only when you have a ship on it' do
        squad.generate_profits!
        squad.credits.should == 0
      end
    end
    context 'changing producing unit on a facility fleet' do
      before(:each) do
        @facility_fleet = Factory :facility_fleet
        @facility_fleet.generic_unit.factions= squad.faction
        @unit = Factory :unit
      end
      it 'should not change its credits if facility doesnt have a producing unit yet' do
        current_credits = squad.credits
        squad.change_producing_unit(@facility_fleet, @unit)
        squad.credits.should == current_credits
      end
      it 'should change its credits if facility already have a producing unit' do
        squad.credits = 1000
        @facility_fleet.producing_unit = @unit
        new_unit = Factory :unit
        squad.change_producing_unit(@facility_fleet, new_unit)
        squad.credits.should be 0
      end
    end

    context 'randomizing a planet' do
      before(:each) do
        5.times do
          squad.planets << Factory(:planet)
        end
      end

      it 'should retrieve a planet' do
        current_planet = squad.planets.first
        random = squad.random_planet_but(current_planet).should_not == current_planet
      end
      it 'should return false if we just have one planet' do
        squad.planets.clear
        current_planet = Factory :planet
        squad.planets << current_planet
        squad.random_planet_but(current_planet).should be_false
      end
    end

    context 'moving through phases' do
      it 'should be able to go through the move phase' do
        squad.end_move_round
        squad.move?.should be_true
      end
    end
  end

  context 'using factions' do
    it 'should have a faction' do
      squad.faction.should == 'empire'
    end
  end
  context 'warping ships' do
    let(:planet) {Factory :planet}
    context 'like capital ships' do
      let!(:capital_ship) {Factory :capital_ship}
      before do
        squad.warp_capital_ship_on planet
      end

      it 'should create a fleet' do
        squad.fleets.should be
      end
      it 'should be a capital ship' do
        squad.fleets.first.generic_unit.should be_a CapitalShip
      end
    end
  end
end

