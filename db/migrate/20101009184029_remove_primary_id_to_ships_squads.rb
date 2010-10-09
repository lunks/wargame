class RemovePrimaryIdToShipsSquads < ActiveRecord::Migration
  def self.up
   remove_column :ships_squads, :id
  end

  def self.down
    add_column :ships_squads, :id, :integer
  end
end

