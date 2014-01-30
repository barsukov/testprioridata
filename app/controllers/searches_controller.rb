class SearchesController < ApplicationController
  attr_accessor :company_results,:product_results

  #This is decision is not good  for production code, but reason only for pagination, and I did not divide these result
  # by ajax request, and separate to another actions
  def index

    @company_results = session[:tmp_companies]
    @product_results = session[:tmp_products]

    company_page = params[:company_page] || 1
    product_page = params[:product_page] || 1

    @product_results = @product_results.paginate(:page =>params[:product_page]) if @product_results
    @company_results = @company_results.paginate(:page => params[:company_page]) if @company_results


    respond_to do |format|
      format.html{ render "result"}
    end
  end

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

        #clear session storage
        session[:tmp_companies] = nil
        session[:tmp_products] = nil

        #save collection to temproray session variables , need to divde it this is not good way for production
        session[:tmp_companies] = @company_results
        session[:tmp_products] = @product_results
        #wrap array to paginataion array
        @company_results = @company_results.paginate(:page => 1,:per_page => 3)  if @company_results
        @product_results = @product_results.paginate(:page =>1,:per_page => 3)   if @product_results


        format.html{ render "result"}
      end
  end
end
