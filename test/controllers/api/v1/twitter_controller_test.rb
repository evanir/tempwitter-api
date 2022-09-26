require 'test_helper'
module Api::V1
  class TwitterControllerTest  < ActionDispatch::IntegrationTest  #< Minitest::Test
    test "should get forecast"  do
      get api_v1_twitter_forecast_url(city_name: 'Campinas', format: :json)
      assert_response :success
    end
  end
end
