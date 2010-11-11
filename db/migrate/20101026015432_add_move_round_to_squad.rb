class AddMoveRoundToSquad < ActiveRecord::Migration
  def self.up
    add_column :squads, :move, :boolean
  end

  def self.down
    remove_column :squads, :move
  end
end
