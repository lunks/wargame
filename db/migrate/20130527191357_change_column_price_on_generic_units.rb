class ChangeColumnPriceOnGenericUnits < ActiveRecord::Migration
  def self.up
    change_column :generic_units, :price, :integer
  end

  def self.down
    change_column :generic_units, :price, :float
  end
end
