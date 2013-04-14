class AddDescriptionToGenericUnits < ActiveRecord::Migration
  def self.up
    add_column :generic_units, :description, :string
  end

  def self.down
    remove_column :generic_units, :description
  end
end
