require 'httparty'
class WeatherData
  attr_accessor :data, :cached
  def initialize(zip_code, unit)
    @zip_code = zip_code
    @cached = true
    @unit = unit
  end

  def data
    Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
      @cached = false
      latest_data
    end
  end

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
     current_data: current_data(response),
     forecast_data: forecast_data(response)
    }
  end

  def current_data(response)
    {
     location: {
      name: response["location"]["name"],
      region: response["location"]["region"]
     },
     temp: response["current"][unit_temp_key],
     condition: response["current"]["condition"]["text"],
     feelslike: response["current"][unit_feelslike_key]
    }
  end

  def forecast_data(response)
    forecast_data = response["forecast"]
    forecast_data["forecastday"].map do |day|
      {
       date: day["date"],
       maxtemp: day["day"][unit_maxtemp_key],
       mintemp: day["day"][unit_mintemp_key],
      }
    end
  end

  def url
    "http://api.weatherapi.com/v1/forecast.json?key=#{WEATHER_API_KEY}&q=#{@zip_code}&days=10&aqi=no&alerts=no"
  end

  def cache_key
    "weather_#{@zip_code}"
  end

  def unit_temp_key
    @unit == "fahrenheit" ? "temp_f" : "temp_c"
  end

  def unit_feelslike_key
    @unit == "fahrenheit" ? "feelslike_f" : "feelslike_c"
  end

  def unit_maxtemp_key
    @unit == "fahrenheit" ? "maxtemp_f" : "maxtemp_c"
  end

  def unit_mintemp_key
    @unit == "fahrenheit" ? "mintemp_f" : "mintemp_c"
  end
end
