class AddShipIdToOwnedShip < ActiveRecord::Migration
  def self.up
    add_column :owned_ships, :ship_id, :integer
  end

  def self.down
    remove_column :owned_ships, :ship_id
  end
end
