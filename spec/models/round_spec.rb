require 'spec_helper'

describe Round do
  before(:each) do
    Round.create!{[:number => 1]} if Round.last.nil?
  end
  let (:round) {Round.getInstance}
  let! (:rebel) {Factory :squad}
  let! (:empire) {Factory :squad}

  it 'should end moving phase just when all squads ends the moving phase' do
    rebel.end_move_round
    round.should_not be_done_moving
    empire.end_move_round
    round.should be_done_moving
  end

  it 'should be able to return whose turn is it' do
    round.who?.should == rebel
    rebel.end_move_round
    round.who?.should == empire
  end

  context 'beginning a new round' do
    before(:each) do
      empire.destroy # stinking empire!
      rebel.planets.clear
      rebel.facility_fleets.clear
      unit = Factory :fighter, :price => 140
      Factory :capital_ship, :price => 1000
      3.times {Factory.create :planet}
      round.new_game!
    end

    it 'should get a random planet for the squad' do
      rebel.planets(true).should_not be_empty
    end
    it 'should place a facility on the new planet' do
      rebel.facility_fleets(true).should_not be_empty
    end
    it 'should place random units on the planets' do
      rebel.fleets.count.should == 6
    end
  end

  context 'rounds logic' do
  end

end

