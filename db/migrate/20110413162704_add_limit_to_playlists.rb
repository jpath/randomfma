class AddLimitToPlaylists < ActiveRecord::Migration
  def self.up
    add_column :playlists, :limit, :integer
  end

  def self.down
    remove_column :playlists, :limit
  end
end
