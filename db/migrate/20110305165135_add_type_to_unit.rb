class AddTypeToUnit < ActiveRecord::Migration
  def self.up
    add_column :units, :type, :string
  end

  def self.down
    remove_column :units, :type
  end
end
