class AddFleetNameToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :fleet_name, :string
  end

  def self.down
    remove_column :results, :fleet_name
  end
end
