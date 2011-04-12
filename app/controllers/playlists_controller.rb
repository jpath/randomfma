class PlaylistsController < ApplicationController
  def new
    pl = Playlist.create :genre_handle => params[:genre_handle]
    pl.generate 
  end
end
