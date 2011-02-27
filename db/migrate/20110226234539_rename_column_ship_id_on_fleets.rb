class RenameColumnShipIdOnFleets < ActiveRecord::Migration
  def self.up
    rename_column :fleets, :ship_id, :unit_id
  end

  def self.down
    rename_column :fleets, :unit_id, :ship_id
  end
end
