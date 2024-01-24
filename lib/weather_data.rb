class WeatherData
  FAHRENHEIT = 'fahrenheit'
  CELSIUS = 'celsius'
  attr_accessor :data, :cached, :unit
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

  private

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

  # Cache based on zip code and unit
  def cache_key
    "weather_#{@zip_code}_#{@unit}"
  end

  #Helper methods for keys to look up API response based on unit
  def unit_temp_key
    @unit == FAHRENHEIT ? "temp_f" : "temp_c"
  end

  def unit_feelslike_key
    @unit == FAHRENHEIT ? "feelslike_f" : "feelslike_c"
  end

  def unit_maxtemp_key
    @unit == FAHRENHEIT ? "maxtemp_f" : "maxtemp_c"
  end

  def unit_mintemp_key
    @unit == FAHRENHEIT ? "mintemp_f" : "mintemp_c"
  end
end
