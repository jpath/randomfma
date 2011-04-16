class Playlist < ActiveRecord::Base

  serialize :track_urls
  serialize :track_titles
  serialize :track_ids


  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"

  EmbedHtml = %(<object width="300" height="50"><param name="movie" value="http://freemusicarchive.org/swf/trackplayer.swf"/><param name="flashvars" value="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml"/><param name="allowscriptaccess" value="sameDomain"/><embed type="application/x-shockwave-flash" src="http://freemusicarchive.org/swf/trackplayer.swf" width="300" height="50" flashvars="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml" allowscriptaccess="sameDomain" /></object>) 

  def generate
    xml_doc = Nokogiri::XML(tracks_xml)
    self.track_urls = xml_doc.xpath("//track_url").collect {|node| node.content} 
    self.track_titles = xml_doc.xpath("//track_title").collect {|node| node.content} 
    self.track_ids = xml_doc.xpath("//track_id").collect {|node| node.content} 
    save
  end

  def tracks_xml
    Curl::Easy.perform(api_url).body_str
  end

  def api_url
    url = "#{FmaApiUrl}?genre_handle=#{genre_handle}"  
    if limit 
      url += "&limit=#{limit}"
    end
    url
  end
  def self.embedded_player_for_track(id)
    EmbedHtml % [id, id]
  end
end
