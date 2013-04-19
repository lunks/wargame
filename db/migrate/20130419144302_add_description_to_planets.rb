class AddDescriptionToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :description, :string
  end

  def self.down
    remove_column :planets, :description
  end
end
