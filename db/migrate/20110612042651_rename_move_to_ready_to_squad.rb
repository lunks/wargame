class RenameMoveToReadyToSquad < ActiveRecord::Migration
  def self.up
    rename_column :squads, :move, :ready
  end

  def self.down
    rename_column :squads, :ready, :move
  end
end
