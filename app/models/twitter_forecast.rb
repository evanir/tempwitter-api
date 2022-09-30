module TwitterForecast
  class Forecast
    include TwitterClient

    attr_reader :error, :status_message, :status_code

    def initialize(options = {})
      city_id   = options.fetch(:city_id, 0).to_i
      city_name = options.fetch(:city_name, nil)
      @open_weather_forecast = Openweathermap::Sdk::Client.new({ city_id:, city_name: })
      # @open_weather_forecast.perform_requests ???????
      return if @open_weather_forecast.valid?

      @error = @open_weather_forecast.error
      @status_message = I18n.transliterate(@open_weather_forecast.error.message)
      @status_code    = 422
    end

    def publish_summary
      return unless @open_weather_forecast.valid?

      tweet = client.update(tweet_text)
      if tweet.id.present?
        @status_message = 'Tweet enviado com sucesso!'
        @status_code = :ok
      else
        @status_message = 'Falha ao enviar o tweet!'
        @status_code = 422
      end
    end

    # Retorna o texto a ser publicado no Twitter
    def tweet_text
      return nil if @open_weather_forecast.nil? || current_weather.nil?

      "#{@open_weather_forecast.weather_response['main']['temp'].to_i}ºC e #{current_weather['description']}"\
      " em #{@open_weather_forecast.weather_response['name']} em #{today_s}."\
      " Média para os próximos dias: #{average_text}"
    end

    private

    # Retorna um hash com valores coletados da temperatura atual
    # ex: {"id"=>501, "main"=>"Rain", "description"=>"chuva moderada", "icon"=>"10d"}
    def current_weather
      return nil if @open_weather_forecast.weather_response.nil?

      @open_weather_forecast.weather_response['weather'][0]
    end

    # Retorna uma hash sendo as chaves a data e os valores um array com as previsoes para o dia
    # é usada para o calculo da média do dia.
    def summary_forecast
      return nil if @open_weather_forecast.forecast_response.nil?

      @summary_forecast ||= build_summary_forecast
    end

    # retorna uma hash com a média  dos 5 dias seguintes
    # ex:  {"01/10"=>24.42, "02/10"=>25.75, "03/10"=>24.76, "04/10"=>21.77, "05/10"=>23.32}
    def average_summary
      return @average_summary unless @average_summary.nil?

      @average_summary = {}
      summary_forecast.each do |day, temp|
        @average_summary[day] = (temp.sum / temp.size).round(2)
      end
      @average_summary
    end

    # retorna o texto da média
    # é usado para compor o tweet_text
    def average_text
      return @average_text unless @average_text.nil?

      @average_text = ''
      average_summary.each do |day, avg|
        @average_text += " #{avg.to_i}ºC em #{day},"
      end
      @average_text[-1] = '.'
      @average_text
    end

    def build_summary_forecast
      @summary_forecast = {}
      @open_weather_forecast.forecast_response['list'].each do |list|
        forecast_date = Time.at(list['dt']).to_date
        short_date = forecast_date.strftime('%d/%m')
        next if forecast_date.today?

        @summary_forecast[short_date] ||= []
        @summary_forecast[short_date] << list['main']['temp']
      end
      @summary_forecast
    end

    def today_s
      "#{Date.today.day}/#{Date.today.month}"
    end
  end
end
