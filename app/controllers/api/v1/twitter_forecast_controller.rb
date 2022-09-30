module Api::V1
  class TwitterForecastController < ApplicationController

    def tweet
      city_name = I18n.transliterate(params[:city_name] || 'Brasilia')
      city_id = params[:city_id]
      tweet_forecast = TwitterForecast::Forecast.new({city_id: city_id, city_name: city_name})
      tweet_forecast.publish_summary
      render json: { message: tweet_forecast.status_message }, status: tweet_forecast.status_code
    end

    def callback
    end
  end
end
