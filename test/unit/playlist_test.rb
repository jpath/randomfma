require 'test_helper'

class PlaylistTest < ActiveSupport::TestCase
  def setup
    @pl = Playlist.new :genre_handle => "Blues"
  end
  test "Playlistmaker should generate a playlist \
  using the passed genre_handle" do
    assert_equal @pl.genre_handle, "Blues"
  end

  test "Playlist should know the FMA Api URL" do
    assert_equal  "http://freemusicarchive.org/api/get/tracks.xml?genre_handle=Blues",@pl.api_url
  end

end
