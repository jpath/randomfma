require 'test_helper'

class PlaylistsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the create action" do
    pl = Playlist.new
    pl.expects(:generate)
    get :create, :genre_handle => "Blues", :limit => 1
    assert_redirected_to playlist_path(:id => assigns(:pl).id)
  end
end
