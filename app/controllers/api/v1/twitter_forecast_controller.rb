# frozen_string_literal: true

# Controller da API TwitterForecastController
# Modulo API
module Api
  # modulo versão 1
  module V1
    # Classe Twitter Forecast Controller
    class TwitterForecastController < ApplicationController
      # Esse metodo publica o tweet com a previsao com a temperatura atual
      # e a media para os proximos 5 dias
      # @param city_id ou city_name
      def tweet
        city_name = I18n.transliterate(params.fetch(:city_name, ""))
        city_id = params[:city_id]
        tweet_forecast = TwitterForecast::Forecast.new({ city_id: city_id, city_name: city_name})
        tweet_forecast.publish_summary
        render json: { message: tweet_forecast.status_message }, status: tweet_forecast.status_code
      end

      def callback; end
    end
  end
end
