class AddLastPlayerIdToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :last_player_id, :integer
  end

  def self.down
    remove_column :planets, :last_player_id
  end
end
