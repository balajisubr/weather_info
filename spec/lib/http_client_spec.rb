require './lib/http_client.rb'
require './spec/spec_helper.rb'
require './spec/rails_helper.rb'

RSpec.describe HttpClient do
   let(:client) { described_class.new('http://dummy') }
   let(:response) { OpenStruct.new(body: {a: 1}.to_json, code: 200) }
   before do
     allow(HTTParty).to receive(:get).and_return(response)
   end
   context 'no error' do
     it 'returns response body' do
       client.fetch_data
       expect(client.body).to eq({"a"=> 1})
       expect(client.error_msg).to eq(nil)
     end
   end

   context 'with error' do
     let(:response) { OpenStruct.new('error' => {'message' => 'Invalid input'}, code: 400 ) }     
     it 'returns error' do
       client.fetch_data
       expect(client.error_msg).to eq('Invalid input')
     end
   end
end

