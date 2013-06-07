class AddProducingUnitIdToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :producing_unit_id, :integer
    add_column :results, :producing_unit2_id, :integer
  end

  def self.down
    remove_column :results, :producing_unit_id
    remove_column :results, :producing_unit2_id
  end
end
