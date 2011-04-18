class Playlist < ActiveRecord::Base

  serialize :track_urls
  serialize :track_titles
  serialize :track_ids

  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"

  EmbedHtml = %(<object width="300" height="50"><param name="movie" value="http://freemusicarchive.org/swf/trackplayer.swf"/><param name="flashvars" value="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml"/><param name="allowscriptaccess" value="sameDomain"/><embed type="application/x-shockwave-flash" src="http://freemusicarchive.org/swf/trackplayer.swf" width="300" height="50" flashvars="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml" allowscriptaccess="sameDomain" /></object>) 


  def limit
    5
  end

  def generate
    # TODO: track model
    self.track_urls = []
    self.track_titles = []
    self.track_ids = []
    num_pages = pages_for_genre
    page_numbers = []
    limit.times do
      page_numbers << rand(num_pages)
    end
    page_numbers.each do |num|  
      doc = xml_doc(tracks_xml(true, {:limit => 1, :page => num}))
      self.track_urls << doc.xpath("//track_url")[0].content 
      self.track_titles << doc.xpath("//track_title")[0].content 
      self.track_ids << doc.xpath("//track_id")[0].content 
    end
    save
  end

  def tracks_xml expire_cache, opts = {}
    if @tracks_xml.nil? || expire_cache  
      @tracks_xml = Curl::Easy.perform(api_url(opts)).body_str
    else
      @tracks_xml
    end
  end

  def xml_doc xmlstr
    @xml_doc = Nokogiri::XML(xmlstr)
  end

  def api_url opts = {}
    url = "#{FmaApiUrl}?genre_handle=#{genre_handle}"  
    opts.each {|k,v| url += "&#{k}=#{v}"}
    url
  end

  def pages_for_genre
    xml_doc(tracks_xml(true, {:limit => 1})).xpath("//total_pages")[0].content.to_i
  end

  def self.embedded_player_for_track(id)
    EmbedHtml % [id, id]
  end
end
