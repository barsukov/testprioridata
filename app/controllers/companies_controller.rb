class CompaniesController < ApplicationController
  def show
    crunch_base_response = pusher.send_company_request_to_crunch_base({:name => params[:name]})
    if crunch_base_response
      @result = JSON.parse crunch_base_response
      @company = Company.new
      @company.crunch_base_url = @result["crunchbase_url"]
      @company.people  = @result["relationships"]
      @company.name =   @result["name"]
      @company.img_max_url= "#{Constants::CRUNCH_URL}#{@result.try(:[],"image").try(:[],"available_sizes").try(:last).try(:last)}"
      @company.overview = @result["overview"]
    end
  end
end
