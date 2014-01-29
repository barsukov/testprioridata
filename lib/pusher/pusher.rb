class Pusher < BasePusher
  def send_search_request_to_crunch_base(params = {},url=SEARCH_URL)
    begin
      params[:api_key] = API_KEY
      response = RestClient.get url, :params => params
      response
    rescue => e
      e.response
    end
  end

  %w(company product).each do |model|
    define_method "send_#{model}_request_to_crunch_base" do |params = {}|
     request_url = "#{BASE_URL}#{model}/#{params[:name]}.js"
     send_search_request_to_crunch_base params,request_url
    end
  end
end