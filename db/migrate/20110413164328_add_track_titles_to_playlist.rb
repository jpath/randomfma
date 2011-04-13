class AddTrackTitlesToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :playlists, :track_titles, :text
  end

  def self.down
    remove_column :playlists, :track_titles
  end
end
