class AddCaptorIdToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :captor_id, :integer
  end

  def self.down
    remove_column :results, :captor_id
  end
end
