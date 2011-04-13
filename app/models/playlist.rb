class Playlist < ActiveRecord::Base
  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"

  def generate
    tracks_xml = Curl::Easy.perform(api_url).body_str
    xml_doc = Nokogiri::XML(tracks_xml)
    @track_urls = xml_doc.xpath("//track_url").collect {|node| node.content} 
  end

  def api_url
    return "#{FmaApiUrl}?genre_handle=#{genre_handle}"  
  end
end
