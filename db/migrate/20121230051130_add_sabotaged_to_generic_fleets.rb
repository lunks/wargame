class AddSabotagedToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :sabotaged, :boolean
  end

  def self.down
    remove_column :generic_fleets, :sabotaged
  end
end
