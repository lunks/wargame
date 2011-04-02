require 'spec_helper'

describe Round do
  before(:each) do
    Round.create!{[:number => 1]} if Round.last.nil?
  end
  let (:round) {Round.getInstance}
  let! (:rebel) {Factory :rebels}
  let! (:empire) {Factory :empire}

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
      2.times {Factory.create :planet}
      round.new_game!
    end

    it 'should get a random planet for the squad' do
      rebel.planets(true).should_not be_empty
    end
    it 'should place a factory on the new planet' do
      rebel.facilities(true).should_not be_empty
    end
    it 'should place random units on the planets' do
      rebel.fleets.count.should == 6
    end
  end
end

