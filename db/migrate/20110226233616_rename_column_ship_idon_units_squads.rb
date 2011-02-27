class RenameColumnShipIdonUnitsSquads < ActiveRecord::Migration
  def self.up
    rename_column :units_squads, :ship_id, :unit_id
  end

  def self.down
    rename_column :units_squads, :unit_id, :ship_id
  end
end
