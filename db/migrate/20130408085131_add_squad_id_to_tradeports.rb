class AddSquadIdToTradeports < ActiveRecord::Migration
  def self.up
    add_column :tradeports, :squad_id, :integer
  end

  def self.down
    remove_column :tradeports, :squad_id
  end
end
