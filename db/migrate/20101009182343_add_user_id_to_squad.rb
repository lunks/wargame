class AddUserIdToSquad < ActiveRecord::Migration
  def self.up
    add_column :squads, :user_id, :integer
  end

  def self.down
    remove_column :squads, :user_id
  end
end
