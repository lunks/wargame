require 'spec_helper'

describe Squad do
  let(:squad) {Factory :squad}
  it {should have_many :planets}
  it {should have_and_belong_to_many :generic_units }
  it {should have_many :generic_fleets}
  context 'buying and selling facilities' do
    let(:facility) {Factory :facility, :price => 1000}
    let(:planet) {Factory :planet}
    before(:each) do
      squad.facilities << facility
    end
    context 'buying facilities' do
      it 'should be able to buy facilities and remove credits accordingly' do
        squad.credits = 2000
        squad.buy squad.facilities.first, 2, planet
        squad.credits.should be 0
      end

      it 'should not be able to buy a facility they dont have access to' do
        squad.facilities.clear
        squad.buy(facility, 1, planet).should be_false
      end

      it 'should not buy a ship that is not a facility' do
        squad.buy(facility, 1, planet).should be_true
        normal_ship = Factory :unit
        squad.units << normal_ship
        squad.buy(normal_ship, 1, planet).should be_false
      end

      it 'should be able to buy a facility they have access to' do
        squad.buy(facility, 1, planet).should be_true
      end

      it 'should add the facility to the list of Fleets' do
        squad.buy facility, 1, planet
        squad.generic_fleets.should_not be_empty
      end

      it 'should be able buy facilitys and send them specifically to a planet' do
        squad.buy facility, 1, planet
        first = squad.facilities.first
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
    context 'moving through phases' do
      it 'should be able to go through the move phase' do
        squad.end_move_round
        squad.move?.should be_true
      end
    end

  end

end

