class CreateShipsSquads < ActiveRecord::Migration
  def self.up
    create_table :ships_squads do |t|
      t.references :ships
      t.references :squads
    end
  end

  def self.down
    drop_table :ships_squads
  end
end

