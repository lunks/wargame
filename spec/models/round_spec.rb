require 'spec_helper'

describe Round do
  before(:each) do
    Round.create!{[:number => 1]} if Round.last.nil?
  end
  let (:round) {Round.getInstance}
  let (:squad1) {Factory :squad}
  let (:squad2) {Factory :squad}
  it 'should end moving phase just when all squads ends the moving phase' do
    squad1.end_move_round
    squad2.save # shouldn't be needed, not sure
    round.should_not be_done_moving
    squad2.end_move_round
    round.should be_done_moving
  end

  it 'should be able to return whose turn is it' do
    squad1.save
    squad2.save
    round.who?.should == squad1
    squad1.end_move_round
    round.who?.should == squad2
  end

end

