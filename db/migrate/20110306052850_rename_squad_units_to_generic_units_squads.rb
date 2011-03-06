class RenameSquadUnitsToGenericUnitsSquads < ActiveRecord::Migration
  def self.up
    rename_table :squads_units, :generic_units_squads
  end

  def self.down
  end
end

