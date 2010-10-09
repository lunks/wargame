class CreateOwnedShips < ActiveRecord::Migration
  def self.up
    create_table :owned_ships do |t|
      t.references :squad
      t.references :planet
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :owned_ships
  end
end
