class Goal < ActiveRecord::Base

  def self.get_goal
    free_goals = self.where(:used => nil)
    goal = free_goals[rand(free_goals.count - 1)]
    goal.update_attributes(:used => true)
    goal
  end
end

