class RenameShipsToUnits < ActiveRecord::Migration
  def self.up
    rename_table :ships, :units
  end

  def self.down
    rename_table :units, :ships
  end
end
