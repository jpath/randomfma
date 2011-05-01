class RemoveTracksFromPlaylist < ActiveRecord::Migration
  def self.up
    remove_column :playlists, :track_ids
    remove_column :playlists, :track_urls
    remove_column :playlists, :track_titles
  end

  def self.down
    add_column :playlists, :track_ids, :text
    add_column :playlists, :track_urls, :text
    add_column :playlists, :track_titles, :text
  end
end
