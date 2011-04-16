class TracksController < ApplicationController
  def show
    @fma_track_id = params[:id] 
    @player_html = Playlist.embedded_player_for_track(@fma_track_id);
  end

end
