class AddGenreHandleToPlaylists < ActiveRecord::Migration
  def self.up
    add_column :playlists, :genre_handle, :string 
  end

  def self.down
    remove_column :playlists, :genre_handle
  end
end
