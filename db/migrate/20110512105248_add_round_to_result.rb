class AddRoundToResult < ActiveRecord::Migration
  def self.up
    add_column :results, :round_id, :integer
  end

  def self.down
    remove_column :results, :round_id
  end
end
