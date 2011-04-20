class Playlist < ActiveRecord::Base

  serialize :track_urls
  serialize :track_titles
  serialize :track_ids

  has_many :tracks
  FmaApiUrl = "http://freemusicarchive.org/api/get/tracks.xml"

  EmbedHtml = %(<object width="300" height="50"><param name="movie" value="http://freemusicarchive.org/swf/trackplayer.swf"/><param name="flashvars" value="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml"/><param name="allowscriptaccess" value="sameDomain"/><embed type="application/x-shockwave-flash" src="http://freemusicarchive.org/swf/trackplayer.swf" width="300" height="50" flashvars="track=http://freemusicarchive.org/services/playlists/embed/track/%s.xml" allowscriptaccess="sameDomain" /></object>) 


  def limit
    5
  end

  def generate
    num_pages = pages_for_genre
    page_numbers = []
    limit.times do
      page_numbers << rand(num_pages)
    end
    page_numbers.each do |num|  
      doc = xml_doc(tracks_xml(true, {:limit => 1, :page => num}))
      tracks << (Track.new(:url => doc.xpath("//track_url")[0].content,
                           :title => doc.xpath("//track_title")[0].content,
                           :artist_url => doc.xpath("//artist_url")[0].content,
                           :album_url => doc.xpath("//album_url")[0].content,
                           :album => doc.xpath("//album_title")[0].content,
                           :artist => doc.xpath("//artist_name")[0].content,
                           :fma_id => doc.xpath("//track_id")[0].content ))
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
