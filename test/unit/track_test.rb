require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  test "a track should know it's playlist" do
    @t = Track.new
    @t.build_playlist(:genre_handle => "Rock")
    assert_not_nil(@t.playlist)
  end
end
