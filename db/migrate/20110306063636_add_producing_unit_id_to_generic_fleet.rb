class AddProducingUnitIdToGenericFleet < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :producing_unit_id, :integer
  end

  def self.down
    remove_column :generic_fleets, :producing_unit_id
  end
end
