class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.integer :vector_a
      t.integer :vector_b
      t.integer :distance
      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
