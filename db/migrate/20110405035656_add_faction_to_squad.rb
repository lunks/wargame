class AddFactionToSquad < ActiveRecord::Migration
  def self.up
    add_column :squads, :faction, :integer
  end

  def self.down
    remove_column :squads, :faction
  end
end
