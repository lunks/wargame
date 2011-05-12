class RenameDestroyedToBlastedToResult < ActiveRecord::Migration
  def self.up
    rename_column :results, :destroyed, :blasted
  end

  def self.down
    rename_column :results, :blasted, :destroyed
  end
end
