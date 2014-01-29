class SearchesController < ApplicationController

  def create
      #For High Cohesion and Low coupling when we testing applicaiton in spec
      # I moved code with calling remote services to specific klass Pusher
      crunch_base_response = pusher.send_search_request_to_crunch_base({:query => params[:query]})
      if crunch_base_response
        @result = JSON.parse crunch_base_response
        results = @result['results']
        @company_results = []
        @product_resu
lts = []
        #in production code of course these need to be a separate and acces by ajax request and represent by a good view interface on the client side
        #but I do not want to spent time for it on this simple task and represetnt both results on one page in a separate table
        if results
          results.each_with_index do |element, index|
            element["id"] = index
            element["img_min_url"] = "#{Constants::CRUNCH_URL}#{element.try(:[],"image").try(:[],"available_sizes").try(:first).try(:last)}"
            if element["namespace"] == "company"
              @company_results << Company.create_by_crunch_based(element)
            else if element["namespace"] == "product"
              @product_results << Product.create_by_crunch_based(element)
            end
          end
          end
        end
      end
      respond_to do |format|
        format.html{ render "result"}
      end
  end
end
