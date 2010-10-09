class RenamePrecoOnShip < ActiveRecord::Migration
  def self.up
    rename_column :ships, :preco, :price
  end

  def self.down
    rename_column :ships, :price, :preco
  end
end

