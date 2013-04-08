require 'spec_helper'

describe Goal do

  it 'should give a goal' do
    2.times { Factory(:goal) }
    squad = Factory(:squad)
    squad.goal = Goal.get_goal
    squad.save
    squad.goal.should be_present
    squad2 = Factory(:squad)
    squad2.goal = Goal.get_goal
    squad2.save
    squad2.goal.should be_present
    squad.goal.should_not == squad2.goal
  end

end

