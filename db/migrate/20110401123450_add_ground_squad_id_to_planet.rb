class AddGroundSquadIdToPlanet < ActiveRecord::Migration
  def self.up
    add_column :planets, :ground_squad_id, :integer
  end

  def self.down
    remove_column :planets, :ground_squad_id
  end
end
