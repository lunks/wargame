class AddWormholeToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :wormhole, :boolean
  end

  def self.down
    remove_column :planets, :wormhole
  end
end
