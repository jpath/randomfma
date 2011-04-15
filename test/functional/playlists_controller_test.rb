require 'test_helper'

class PlaylistsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the create action" do
    @pl = Playlist.new  :name => "test", :limit => 1
    @pl.id = 1
    mock(Playlist).create(:genre_handle => "Blues", :limit => 1) {@pl}
    mock(@pl).generate
    post :create, :genre_handle => "Blues", :limit => 1
    assert_redirected_to playlist_path(:id => assigns(:pl).id)
  end

  test "show action displays a page of playlist links" do
    @pl = Playlist.new :genre_handle => "Rock", :limit => 1, :track_urls => ["http://fma.org/track1"], 
      :track_titles => ["Track 1"]
    mock(Playlist).find(1) {@pl}
    get :show, :id => 1
    assert_select "a", @pl.track_titles[0]
    assert_select "a[href=#{@pl.track_urls[0]}]" 
  end

end
