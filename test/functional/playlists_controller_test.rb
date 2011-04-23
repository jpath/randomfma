require 'test_helper'

class PlaylistsControllerTest < ActionController::TestCase
  def setup 
    @pl = Playlist.new :genre_handle => "Rock", :limit => 1
    @pl.tracks << Track.new(:url => "http://fma.org/track1", 
      :title => "Track 1", :fma_id => "1", 
      :album => "album1", :artist => "artist1",
      :artist_url => "http://fma.org/artist1",
      :album_url => "http://fma.org/album1")
    @pl.id = 1
    stub(Playlist).find(1) {@pl}
  end

  test "the create action redirects to show the new playlist" do
    mock(Playlist).create(:genre_handle => "Rock", :limit => 1) {@pl}
    mock(@pl).generate
    post :create, :genre_handle => "Rock", :limit => 1
    assert_redirected_to playlist_path(:id => assigns(:pl).id)
  end

  test "show action displays a page of playlist links" do
    mock(Playlist).find(1) {@pl}
    get :show, :id => 1
    assert_select "a", @pl.tracks.first.title
    assert_select "a[href=#{@pl.tracks.first.url}]" 
  end

  test "show action displays link to album" do
    get :show, :id => 1
    assert_select "a", @pl.tracks.first.album
    assert_select "a[href=#{@pl.tracks.first.album_url}]" 
  end

  test "show action displays link to artist" do
    get :show, :id => 1
    assert_select "a", @pl.tracks.first.artist
    assert_select "a[href=#{@pl.tracks.first.artist_url}]" 
  end

  test "show action has button to generate another playlist" do
    get :show, :id => 1
    assert_select "a", "Get Five More"
    assert_select "a[href=#{playlists_path(:genre_handle => 'Rock')}]" 
  end

  test "links in list have an id" do 
    get :show, :id => 1
    assert_select "a[id=track-link-1]" 
  end

  test "links in list have a class attribute" do 
    get :show, :id => 1
    assert_select "a[class=track-link]" 
  end

end
