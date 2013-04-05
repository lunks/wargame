class CreateTradeports < ActiveRecord::Migration
  def self.up
    create_table :tradeports do |t|
      t.references :generic_unit
      t.references :planet
      t.integer :quantity
      t.integer :negotiation_rate
      t.timestamps
    end
  end

  def self.down
    drop_table :tradeports
  end
end
