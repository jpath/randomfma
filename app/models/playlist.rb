class Playlist < ActiveRecord::Base
  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"
  def generate
    api_url
  end

  def api_url
    return "#{FmaApiUrl}?genre_handle=#{genre_handle}"  
  end
end
