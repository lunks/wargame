require 'spec_helper'

describe Squad do
  let(:squad) {Factory :squad}
  it {should have_many :planets}
  it {should have_and_belong_to_many :ships }
  it {should have_many :owned_ships}
  context 'buying and selling ships' do
    let(:ship) {Factory :ship}
    before(:each) do
      squad.ships << ship
    end
    context 'buying ships' do
      it 'should be able to buy ships and remove credits accordingly' do
        squad.credits = 2000
        squad.ships.first.price = 1000
        squad.buy squad.ships.first, 2
        squad.credits.should be_zero
      end

      it 'should not be able to buy a ship they dont have access to' do
        squad.ships.clear
        squad.buy(ship, 1).should be_false
      end

      it 'should be able to buy a ship they have access to' do
        squad.buy(ship, 1).should be_true
      end

      it 'should add the ship to the list of Owned Ships' do
        squad.buy ship, 1
        squad.owned_ships.should_not be_empty
      end

      it 'should be able to accumulate same ship models' do
        squad.buy ship, 1
        squad.buy ship, 1
        squad.owned_ships.count.should be 1
      end

      it 'should be able buy ships and send them specifically to pool' do
        squad.buy ship, 1
        first = squad.owned_ships.first
        first.planet = Factory :planet
        first.save
        squad.buy ship, 1
        squad.owned_ships.count.should be 2
      end
    end

    context 'selling ships' do
      before(:each) do
        squad.ships.first.price = 1000
        squad.ships.first.save!
        squad.buy squad.ships.first, 2
        squad.credits = 0
      end

      it 'should restore credits when selling a ship' do
        squad.sell squad.ships.first, 2
        squad.credits.should be 2000
      end

      it 'should remove the adequate quantity' do
        squad.sell squad.ships.first, 1
        squad.owned_ships.should_not be_empty
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

      pending 'should generate profits only when you have a ship on it' do
        squad.generate_profits!
        squad.credits.should == 0
      end
    end
    context 'moving through phases' do
      it 'should be able to go through the move phase' do
        squad.end_move_round
        squad.move?.should be_true
      end
    end

  end

end

