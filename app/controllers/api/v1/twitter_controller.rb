module Api::V1
  class TwitterController < ApplicationController
    def tweet_forecast
      city_name = I18n.transliterate(params[:city_name] || 'Brasilia')
      forecast = Openweathermap::Sdk::Client.new({city_name: city_name})
      twitter_client = TwitterClient.new().client
      twitter_client.update("Testando ... #{city_name} #{Time.zone.now}")
      # render json: twitter_client.response.to_json
    end

    def callback
    end
  end
end
