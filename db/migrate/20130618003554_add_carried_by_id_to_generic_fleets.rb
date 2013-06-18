class AddCarriedByIdToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :carried_by_id, :integer
  end

  def self.down
    remove_column :generic_fleets, :carried_by_id
  end
end
