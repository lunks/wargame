class RemovePlanetToTradeports < ActiveRecord::Migration
  def self.up
    remove_column :tradeports, :planet_id
  end

  def self.down
    add_column :tradeports, :planet_id, :integer
  end
end
