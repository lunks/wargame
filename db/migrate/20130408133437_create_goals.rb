class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.text :description
    end
  end

  def self.down
    drop_table :goals
  end
end
