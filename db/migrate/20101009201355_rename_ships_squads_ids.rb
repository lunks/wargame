class RenameShipsSquadsIds < ActiveRecord::Migration
  def self.up
    rename_column :ships_squads, :ships_id, :ship_id
    rename_column :ships_squads, :squads_id, :squad_id
  end

  def self.down
    rename_column :ships_squads, :ship_id, :ships_id
    rename_column :ships_squads, :squad_id, :squads_id
  end
end

