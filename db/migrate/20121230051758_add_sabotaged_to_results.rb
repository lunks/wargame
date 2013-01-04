class AddSabotagedToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :sabotaged, :integer
  end

  def self.down
    remove_column :results, :sabotaged
  end
end
