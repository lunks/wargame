class AddTypeToFleets < ActiveRecord::Migration
  def self.up
    add_column :fleets, :type, :string
  end

  def self.down
    remove_column :fleets, :type
  end
end
