class AddUrlToSquads < ActiveRecord::Migration
  def self.up
    add_column :squads, :url, :string
  end

  def self.down
    remove_column :squads, :url
  end
end
