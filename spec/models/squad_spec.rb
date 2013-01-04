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
        squad.credits = 1000
        squad.buy facility, 1, planet
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
  end

  context 'using factions' do
    it 'should have a faction' do
      squad.faction.should == 'empire'
    end
  end

  context 'warping units' do
    let(:planet) {Factory :planet}
    context 'like fighters' do
      before do
        fighter = Factory(:fighter)
        squad.warp_units 5000, Fighter, planet
      end
      it 'should create a fleet' do
        squad.fleets.should be
      end     
      it 'should be a fighter' do
        squad.fleets.first.generic_unit.should be_a Fighter
      end
      it 'should create apropriate quantity' do
        fighter = Factory(:fighter)
        squad.fleets.first.quantity.should == 5000 / fighter.price
      end

    end
    context 'like capital ships' do
      before do
        capital_ship = Factory(:capital_ship, :price => 500)
        squad.warp_units 1000, CapitalShip, planet
      end
      it 'should be a capital ship' do
        squad.fleets.first.generic_unit.should be_a CapitalShip
      end
      it 'should cost 500 credits' do
        squad.fleets.first.generic_unit.price.should == 500
      end        
    end
    context 'like troopers' do
      it 'should be a trooper' do
        trooper = Factory(:trooper)
        squad.warp_units 1000, Trooper, planet
        squad.fleets.first.generic_unit.should be_a Trooper
      end
    end
  end

  context 'transfering credits between squads' do
    before(:each) do
      squad.credits = 1000
      @squad2 = Factory :squad
      @squad2.credits = 0
    end
    it 'should debit credits if it has balance' do
      squad.transfer_credits 1000, @squad2
      squad.credits.should == 0
    end
    it 'should not debit credits if it doesnt have balance' do
      squad.transfer_credits 1100, @squad2
      squad.credits.should == 1000
    end
    it 'should deposit credits to another squad' do
      squad.transfer_credits 1000, @squad2
      @squad2.credits.should == 1000
    end
  end

end
