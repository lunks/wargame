class AddFactionMaskToGenericUnit < ActiveRecord::Migration
  def self.up
    add_column :generic_units, :faction_mask, :integer
  end

  def self.down
    remove_column :generic_units, :faction_mask
  end
end
