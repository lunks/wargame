class AddTradeportToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :tradeport, :boolean
  end

  def self.down
    remove_column :planets, :tradeport
  end
end
