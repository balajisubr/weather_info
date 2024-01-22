require 'httparty'
class HttpClient
attr_accessor :error_msg, :body
  def initialize(url)
    @url = url
    @response = nil
  end
  
  def fetch_data
    @response = HTTParty.get(@url)
  end
  
  def response_code
    @response.code
  end
  
  def body
    JSON.parse(@response.body)
  end
  
  def error_msg
    return @response['error']['message'] if response_code != 200
  
    nil
  end
end
