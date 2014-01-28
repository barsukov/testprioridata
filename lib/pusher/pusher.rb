class Pusher < BasePusher
  def send_request_to_crunch_base(params = {})
    begin
      params[:api_key] = API_KEY
      response = RestClient.get URL, :params => params
      response
    rescue => e
      e.response
    end
  end
end