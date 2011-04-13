class Playlist < ActiveRecord::Base

  serialize :track_urls

  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"

  def generate
    xml_doc = Nokogiri::XML(tracks_xml)
    self.track_urls = xml_doc.xpath("//track_url").collect {|node| node.content} 
    self.track_titles = xml_doc.xpath("//track_title").collect {|node| node.content} 
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
end
