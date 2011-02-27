class RenameUnitsSquadsToSquadsUnits < ActiveRecord::Migration
  def self.up
    rename_table :units_squads, :squads_units
  end

  def self.down
    rename_table :squads_units, :units_squads
  end
end
