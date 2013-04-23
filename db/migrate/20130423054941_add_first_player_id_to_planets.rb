class AddFirstPlayerIdToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :first_player_id, :integer
  end

  def self.down
    remove_column :planets, :first_player_id
  end
end
