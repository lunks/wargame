class AddFleetNameToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :fleet_name, :string
  end

  def self.down
    remove_column :generic_fleets, :fleet_name
  end
end
