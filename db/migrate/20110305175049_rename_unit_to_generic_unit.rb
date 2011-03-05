class RenameUnitToGenericUnit < ActiveRecord::Migration
  def self.up
    rename_table :units, :generic_units
  end

  def self.down
    rename_table :generic_units, :units
  end
end
