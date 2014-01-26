class ApplicationController < ActionController::Base
  layout "application"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_accessor :pusher

  #Of course for best practise ,
  #this constant should be relocate to Settings gem(or the same) ,but this application too small and it is not important
  API_KEY= "uq6qvrnhyntc2vpn4eymv25t"
  URL = "http://api.crunchbase.com/v/1/search.js"

  def pusher
    @pusher || Pusher.new
  end


end
