class AddColorToSquad < ActiveRecord::Migration
  def self.up
    add_column :squads, :color, :string
  end

  def self.down
    remove_column :squads, :color
  end
end
