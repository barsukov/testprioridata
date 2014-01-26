class Pusher < BasePusher
  def send_request_to_crunch_base(params = {})
    begin
      response = RestClient.get URL, :params => params
      response
    rescue => e
      e.response
    end
  end
end