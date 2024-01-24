Given 'user is on query weather page' do
  visit 'query_weather'
end

When 'they click submit' do
  page.click_button 'Retrieve weather info'
end

Then /^it gives an error "(.+)"$/ do |error_msg|
  page.should have_text(error_msg)
end

When /^they enter (.+) address$/ do |type|
  if type == 'valid'
    address = '5 Eola Dr, Aurora, IL 60504'
  elsif type == 'invalid'
    address = '5 Eola Dr, Aurora, IL 77777'
  end
  page.fill_in 'address', with: address
end

When /^API returns (.+) response$/ do |type|
  if type == 'valid'
    f = File.read('spec/fixtures/valid_response.json')
  elsif type == 'invalid'
    f = File.read('spec/fixtures/invalid_response.json')
  end
  allow_any_instance_of(WeatherData).
    to receive(:latest_data).
    and_return(JSON.parse(f))
end

When 'cache is clear' do
  Rails.cache.clear
end 

Then 'I see weather info' do
  page.should have_text('Weather info for your address')
  page.should have_text('Weather forecast for upcoming days')
end
