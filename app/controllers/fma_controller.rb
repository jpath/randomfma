class FmaController < ApplicationController
  def index
    xml_str = Curl::Easy.perform("http://freemusicarchive.org/api/get/curators.xml").body_str
    xml_doc = Nokogiri::XML(xml_str)
    @curator_names = xml_doc.xpath("//curator_handle")
    
  end
end
