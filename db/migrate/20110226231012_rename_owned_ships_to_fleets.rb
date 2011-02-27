class RenameOwnedShipsToFleets < ActiveRecord::Migration
  def self.up
    rename_table(:owned_ships,:fleets)
  end

  def self.down
    rename_table(:fleets,:owned_ships)
  end
end
