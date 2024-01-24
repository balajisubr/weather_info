class WeatherController < ApplicationController
  def query
  end

  def retrieve_weather_info
    address_info = params[:address]
    if address_info.blank?
      render "query", :locals => { error_msg: "Address is blank. Please enter valid address" } and return
    end

    zip_code_match = params[:address].match(/(\d+)$/)
    zip_code = ""
    if zip_code_match && zip_code_match[1]
      zip_code = zip_code_match[1]
    end
    @info = WeatherData.new(zip_code, params[:unit])
    render "weather/retrieve_weather_info"
  end
end
