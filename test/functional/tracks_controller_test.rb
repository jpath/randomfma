require 'test_helper'

class TracksControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "show should have embedded_player_for_track" do
    mock(Playlist).embedded_player_for_track(1)
    get :show, :id => 1
  end
end
