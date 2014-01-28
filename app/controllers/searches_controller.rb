class SearchesController < ApplicationController


  def new

  end
  def create
      #For High Cohesion and Low coupling when we testing applicaiton in spec
      # I moved code with calling remote services to specific klass Pusher
      crunch_base_response = pusher.send_request_to_crunch_base({:query => params[:query]})
      if crunch_base_response
        @result = JSON.parse crunch_base_response
        @results = @result['results']
      end
      render "result"
  end
end
