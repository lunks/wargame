class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.references :generic_unit
      t.integer :quantity
      t.references :planet
      t.references :generic_fleet
      t.integer :destroyed
      t.integer :captured
      t.integer :fled
      t.references :squad

      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
