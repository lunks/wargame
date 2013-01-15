class ChangeColumnSabotagedOnResult < ActiveRecord::Migration
  def self.up
    change_column :results, :sabotaged, :boolean
  end

  def self.down
    change_column :results, :sabotaged, :integer
  end
end
