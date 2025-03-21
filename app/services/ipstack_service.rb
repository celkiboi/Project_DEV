class IpstackService
  include HTTParty
  base_uri "http://api.ipstack.com"

  def initialize(ip_address)
    @ip = ip_address
    @access_key = Rails.application.credentials.ipstack_api_key
  end

  def fetch_country
    response = self.class.get("/#{@ip}?access_key=#{@access_key}")
    if response.success?
      response.parsed_response["country_name"]
    else
      nil
    end
  end
end
