class RenameUnitIdToGenericUnitIdToGenericUnitsSquads < ActiveRecord::Migration
  def self.up
    rename_column :generic_units_squads, :unit_id, :generic_unit_id
  end

  def self.down
  end
end

