module Api::V1
  class TwitterController < ApplicationController
    def tweet_forecast
      city_name = params[:city_name] || 'Brasilia'
      forecast = Openweathermap::Sdk::Client.new({city_name: city_name})
      twitter_client = TwitterClient.new().client
      twitter_client.update("Testando ...")
      render json: twitter_client.response.to_json
    end

    def callback
      puts "Esta passando aqui..."
      binding.break
    end
  end
end
