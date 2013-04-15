class AddFinalQuantityToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :final_quantity, :integer
  end

  def self.down
    remove_column :results, :final_quantity
  end
end
