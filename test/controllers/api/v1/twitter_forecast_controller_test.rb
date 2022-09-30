require 'test_helper'
module Api::V1
  class TwitterForecastControllerTest  < ActionDispatch::IntegrationTest  #< Minitest::Test
    test "should get forecast"  do
      post api_v1_twitter_forecast_tweet_url(city_name: 'Campinas', format: :json)
      assert_response :success
    end
  end
end
