#require 'curb.rb'
class FmaController < ApplicationController
  def index
    @c = Curl::Easy.perform("http://freemusicarchive.org/api/get/curators.xml")   
  end
end
