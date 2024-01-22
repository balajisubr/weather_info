require "test_helper"

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test "should get query" do
    get weather_query_url
    assert_response :success
  end
end
