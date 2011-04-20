class AddArtistUrlAndAlbumUrlToTrack < ActiveRecord::Migration
  def self.up
    add_column :tracks, :artist_url, :string
    add_column :tracks, :album_url, :string
  end

  def self.down
    remove_column :tracks, :artist_url
    remove_column :tracks, :album_url
  end
end
