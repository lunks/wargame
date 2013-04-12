class ChangeColumnPriceOnGenericUnit < ActiveRecord::Migration
  def self.up
    change_column :generic_units, :price, :float
  end

  def self.down
    change_column :generic_units, :price, :integer
  end
end
