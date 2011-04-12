require 'test_helper'

class PlaylistsControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the new action" do
    get :new, :genre_handle => "Blues"
  end
end
