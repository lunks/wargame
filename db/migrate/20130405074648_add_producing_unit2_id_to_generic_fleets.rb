class AddProducingUnit2IdToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :producing_unit2_id, :integer
  end

  def self.down
    remove_column :generic_fleets, :producing_unit2_id
  end
end
