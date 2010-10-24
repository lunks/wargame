class AddMovingToOwnedShip < ActiveRecord::Migration
  def self.up
    add_column :owned_ships, :moving, :boolean
  end

  def self.down
    remove_column :owned_ships, :moving
  end
end
