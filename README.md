# README

* Ruby version - 2.7.1

* Rails version - 7.1.3 

* Database creation
  Create two databases `apple_weather_test` and `apple_weather_development`

* Inquiry form
  Takes 2 inputs
  * Zipcode
  * Unit of temperature

* API Used
  * weatherapi.com has been used and can make 1 million free calls per month
  * API Key has been defined in config/weather_api.yml

* Routes
  There are two routes in use
  * /query_weather : form that accepts address ending in zipcode as input. User can also enter plain zipcode
  * /weather_info : displays data fetched from API which has been formatted in the UI

* Component to fetch weather data
  * Defined in 'lib/weather_data.rb'
  * Takes zip code and unit as attributes
  * caches for 30 min based on zip code and unit
  * Makes API call to fetch current and forecast data
  * Uses lib/http_client to make HTTP requests to API
  * Used in controller 

* HttpClient
  * wrapper around HTTParty

* How to run the test suite
  `bundle exec rspec spec/lib/weather_data_spec.rb`
  `bundle exec rspec spec/lib/http_client.rb`
  `bundle exec cucumber features/query_weather.feature`

* Caching
  * Caching has been done for 30 minutes based on combination of zipcode and unit
  * Rails cache store has been used
  * Toggle cache using `bundle exec rails dev:cache`
