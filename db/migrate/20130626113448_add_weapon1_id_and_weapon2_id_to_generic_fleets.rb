class AddWeapon1IdAndWeapon2IdToGenericFleets < ActiveRecord::Migration
  def self.up
    add_column :generic_fleets, :weapon1_id, :integer
    add_column :generic_fleets, :weapon2_id, :integer
  end

  def self.down
    remove_column :generic_fleets, :weapon1_id
    remove_column :generic_fleets, :weapon2_id
  end
end
