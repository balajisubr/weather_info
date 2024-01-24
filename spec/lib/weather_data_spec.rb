require './lib/weather_data.rb'
require './spec/spec_helper.rb'
require './spec/rails_helper.rb'
require 'pry'
require 'httparty'
RSpec.describe WeatherData do
  let(:weather_data) { described_class.new('60504', 'fahrenheit') }
  describe 'initialize' do
    it 'has right attributes' do
      expect(weather_data.instance_variable_get(:@zip_code)).to eq('60504')
      expect(weather_data.instance_variable_get(:@cached)).to eq(true)
      expect(weather_data.instance_variable_get(:@unit)).to eq('fahrenheit')
    end
  end

  describe 'data' do
    let(:weather_data1) { described_class.new('60504', 'fahrenheit') }
    before do
      allow(HTTParty).to receive(:get).and_return(OpenStruct.new(body: {a: 1}.to_json, code: 200))
      allow(weather_data).to receive(:latest_data).and_return({current_data: {}, forecast_data: {}})
      allow(weather_data1).to receive(:latest_data).and_return({current_data: {}, forecast_data: {}})
    end

    it 'cached is initially set to false and later set to true for same zipcode' do
      Rails.cache.clear
      weather_data.data
      expect(weather_data.cached).to eq(false)

      weather_data1.data
      expect(weather_data1.cached).to eq(true)
    end 
  end
end
