class AddCreditsToPlanet < ActiveRecord::Migration
  def self.up
    add_column :planets, :credits, :integer
  end

  def self.down
    remove_column :planets, :credits
  end
end
