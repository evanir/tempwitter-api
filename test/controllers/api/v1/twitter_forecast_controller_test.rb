require 'test_helper'
# require 'webmock/minitest'

module Api::V1
  class TwitterForecastControllerTest  < ActionDispatch::IntegrationTest
    test "should post forecast with city_name"  do
      post api_v1_twitter_forecast_tweet_url(city_name: 'Belo Horizonte', format: :json)
      assert_response :success
    end

    test "should get a error with wrong city name" do
      post api_v1_twitter_forecast_tweet_url(city_name: 'Belo HorizonteX', format: :json)
      assert_response :unprocessable_entity
    end

    test "should post forecast with city_id"  do
      post api_v1_twitter_forecast_tweet_url(city_id:  3448439, format: :json)
      assert_response :success
    end

    test "should get a error with wrong city id" do
      post api_v1_twitter_forecast_tweet_url(city_id: 99999999999, format: :json)
      assert_response :unprocessable_entity
    end

    test "should get a success message"  do
      post api_v1_twitter_forecast_tweet_url(city_name: 'Belo Horizonte', format: :json)
      response_json = JSON.parse(response.body)
      assert_equal "Tweet enviado com sucesso!", response_json["message"]
    end

    test "should get a fail message"  do
      post api_v1_twitter_forecast_tweet_url(city_name: 'CampinaX', format: :json)
      response_json = JSON.parse(response.body)
      assert_equal "city not found", response_json["message"]
    end
  end
end
