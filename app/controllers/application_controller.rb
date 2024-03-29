class ApplicationController < ActionController::Base
  extend Constants
  layout "application"
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_accessor :pusher

  def pusher
    @pusher || Pusher.new
  end


end
