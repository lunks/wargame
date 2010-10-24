class AddDestinationIdToOwnedShip < ActiveRecord::Migration
  def self.up
    add_column :owned_ships, :destination_id, :integer
  end

  def self.down
    remove_column :owned_ships, :destination_id
  end
end
