class AddSectorToPlanets < ActiveRecord::Migration
  def self.up
    add_column :planets, :sector, :integer
  end

  def self.down
    remove_column :planets, :sector
  end
end
