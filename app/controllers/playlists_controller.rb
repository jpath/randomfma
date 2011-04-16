class PlaylistsController < ApplicationController
  def show
    @pl = Playlist.find(params[:id])
  end

  def create
    #@pl = Playlist.create :genre_handle => params[:genre_handle], :limit => params[:limit]
    @pl = Playlist.create :genre_handle => params[:genre_handle], :limit => 1
    @pl.generate 
    redirect_to(playlist_path(:id => @pl.id))
  end
end
