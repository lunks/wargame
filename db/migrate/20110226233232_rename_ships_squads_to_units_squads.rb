class RenameShipsSquadsToUnitsSquads < ActiveRecord::Migration
  def self.up
    rename_table :ships_squads, :units_squads
  end

  def self.down
    rename_table :units_squads, :ships_squads
  end
end
