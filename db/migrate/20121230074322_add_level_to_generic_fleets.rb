class AddLevelToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :level, :integer
  end

  def self.down
    remove_column :generic_fleets, :level
  end
end
