class CreateRounds < ActiveRecord::Migration
  def self.up
    create_table :rounds do |t|
      t.integer :number
      t.boolean :move
      t.boolean :attack
      t.boolean :done

      t.timestamps
    end
  end

  def self.down
    drop_table :rounds
  end
end
