class AddUsedToGoals < ActiveRecord::Migration
  def self.up
    add_column :goals, :used, :boolean
  end

  def self.down
    remove_column :goals, :used
  end
end
