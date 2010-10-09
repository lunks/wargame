class AddSquadIdToPlanet < ActiveRecord::Migration
  def self.up
    add_column :planets, :squad_id, :integer
  end

  def self.down
    remove_column :planets, :squad_id
  end
end
