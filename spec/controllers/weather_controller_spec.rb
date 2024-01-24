require './spec/rails_helper'
require './spec/spec_helper'

RSpec.describe WeatherController, type: :controller do
  describe '#query' do
    it 'returns right template' do
      #get '/query_weather'
      #expect(response).to render_template(:query)
    end
  end

  describe '#retrieve_weather_info' do
    let(:address) { '559 Watercress Dr, Aurora, IL-60504' }
    context 'address is empty' do
      let(:address) { nil }
      it 'redirects to query' do
        get '/retrieve_weather_info', params: {address: nil}
        #get '/'
        #get '/retrieve_weather_info', {address: nil}
        #expect(response).to render_file('weather/query')
      end
    end
  end  
end 


