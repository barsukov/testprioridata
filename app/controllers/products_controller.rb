class ProductsController < ApplicationController
  def show
    crunch_base_response = pusher.send_product_request_to_crunch_base({:name => params[:name]})
    if crunch_base_response
      @result = JSON.parse crunch_base_response
      @product = Product.new
      @product.crunch_base_url = @result["crunchbase_url"]
      @product.milestones  = @result["milestones"]
      @product.name =   @result["name"]
      @product.img_max_url= "http://www.crunchbase.com/#{@result.try(:[],"image").try(:[],"available_sizes").try(:last).try(:last)}"
      @product.overview = @result["overview"]
    end
  end
end
