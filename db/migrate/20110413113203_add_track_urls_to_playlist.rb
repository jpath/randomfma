class AddTrackUrlsToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :playlists, :track_urls, :text
  end

  def self.down
    remove_column :playlists, :track_urls
  end
end
