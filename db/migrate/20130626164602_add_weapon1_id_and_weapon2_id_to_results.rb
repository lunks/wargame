class AddWeapon1IdAndWeapon2IdToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :weapon1_id, :integer
    add_column :results, :weapon2_id, :integer
  end

  def self.down
    remove_column :results, :weapon1_id
    remove_column :results, :weapon2_id
  end
end
