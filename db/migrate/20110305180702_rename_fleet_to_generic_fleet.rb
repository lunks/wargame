class RenameFleetToGenericFleet < ActiveRecord::Migration
  def self.up
    rename_table :fleets, :generic_fleets
  end

  def self.down
    rename_table :generic_fleets, :fleets
  end
end
