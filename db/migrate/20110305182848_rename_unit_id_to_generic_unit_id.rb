class RenameUnitIdToGenericUnitId < ActiveRecord::Migration
  def self.up
    rename_column :generic_fleets, :unit_id, :generic_unit_id
  end

  def self.down
    rename_column :generic_fleets, :generic_unit_id, :unit_id
  end
end
