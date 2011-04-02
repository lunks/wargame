class AddBalanceToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :balance, :integer
  end

  def self.down
    remove_column :generic_fleets, :balance
  end
end
