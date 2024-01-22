class BasicWeatherData < WeatherData
  def latest_data
    client = HttpClient.new(url)
    client.fetch_data
    if client.error_msg
      return {
       error: client.error_msg
      }
    end

    response = client.body
    {
     location: {
      name: response["location"]["name"],
      region: response["location"]["region"]
     },
     temp_c: response["current"]["temp_c"],
     temp_f: response["current"]["temp_f"],
     condition: response["current"]["condition"]["text"],
     feelslike_c: response["current"]["feelslike_c"],
     feelslike_f: response["current"]["feelslike_f"]
    }
  end

  def url
    "http://api.weatherapi.com/v1/current.json?key=#{WEATHER_API_KEY}&q=#{@zip_code}&aqi=no"
  end

  def cache_key
    "basic_weather_#{@zip_code}"
  end
end
