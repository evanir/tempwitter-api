module Api::V1
  class TwitterController < ApplicationController
    def forecast
      city_name = params[:city_name] || 'Brasilia'
      forecast = Openweathermap::Sdk::Client.new({city_name: city_name})
      #publish_twitter(forecast)
      render json: forecast.json_response_body

    end
  end
end
