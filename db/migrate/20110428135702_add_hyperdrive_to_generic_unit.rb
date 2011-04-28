class AddHyperdriveToGenericUnit < ActiveRecord::Migration
  def self.up
    add_column :generic_units, :hyperdrive, :boolean
  end

  def self.down
    remove_column :generic_units, :hyperdrive
  end
end
