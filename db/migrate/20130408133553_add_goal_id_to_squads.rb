class AddGoalIdToSquads < ActiveRecord::Migration
  def self.up
    add_column :squads, :goal_id, :integer
  end

  def self.down
    remove_column :squads, :goal_id
  end
end
