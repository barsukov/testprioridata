class SearchesController < ApplicationController

  def create
      #For High Cohesion and Low coupling when we testing applicaiton in spec
      # I moved code with calling remote services to specific klass Pusher
      crunch_base_response = pusher.send_search_request_to_crunch_base({:query => params[:query]})
      if crunch_base_response
        @result = JSON.parse crunch_base_response
        results = @result['results']
        @company_results = []
        @product_results = []
        #in production code of course these need to be a separate and acces by ajax request and represent by a good view interface on the client side
        #but I do not want to spent time for it on this simple task and represetnt both results on one page in a separate table
        if results
          results.each_with_index do |element, index|
            if element["namespace"] == "company"
              @company_results << element
            else if element["namespace"] == "product"
              img_min_url= "http://www.crunchbase.com/#{element.try(:[],"image").try(:[],"available_sizes").try(:first).try(:last)}"
              @product_results << Product.new(id: index ,name: element["name"],
                                              description: element["description"],
                                              img_mini_url: img_min_url,
                                              permalink: element["permalink"])
          end
        end

          end
        end
      render "result"
  end
  end
end
