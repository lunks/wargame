class AddHomePlanetIdToSquads < ActiveRecord::Migration
  def self.up
    add_column :squads, :home_planet_id, :integer
  end

  def self.down
    remove_column :squads, :home_planet_id
  end
end
