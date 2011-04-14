class PlaylistsController < ApplicationController
  def create
    #@pl = Playlist.create :genre_handle => params[:genre_handle]
    @pl = Playlist.create :genre_handle => params[:genre_handle], :limit => params[:limit]
    @pl.generate 
    redirect_to playlist_path(:id => @pl.id)
  end
end
