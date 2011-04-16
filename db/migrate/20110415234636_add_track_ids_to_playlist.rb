class AddTrackIdsToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :playlists, :track_ids, :text
  end

  def self.down
    remove_column :playlists, :track_ids
  end
end
