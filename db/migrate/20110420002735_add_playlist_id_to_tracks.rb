class AddPlaylistIdToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :playlist_id, :integer
  end

  def self.down
    remove_column :tracks, :playlist_id
  end
end
