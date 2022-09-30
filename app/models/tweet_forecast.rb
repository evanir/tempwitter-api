class TweetForecast
  attr_reader :error, :status_message, :status_code

  def initialize(options = {})
    city_id   = options.fetch(:city_id, 0).to_i
    city_name = options.fetch(:city_name, nil)
    @forecast = Openweathermap::Sdk::Client.new({city_id: city_id, city_name: city_name})
    # @forecast.perform_requests ???????
    unless @forecast.valid?
      @error    = @forecast.error
      @status_message = @forecast.error.message
      @status_code    = 422
    end
    @twitter_client = TwitterClient.new.client
  end

  def publish_summary
    return unless @forecast.valid?

    if @twitter_client.update(summary_text)
      @status_message = "Tweet enviado com sucesso!"
      @status_code = :ok
    else
      @status_message = "Falha ao enviar o tweet!"
      @status_code = 422
    end
  end

  def current_weather
    return nil if @forecast.weather_response.nil?

    @forecast.weather_response["weather"][0]
  end

  def summary_forecast
    return nil if @forecast.forecast_response.nil?
    return @summary_forecast unless @summary_forecast.nil?

    @summary_forecast = {}
    @forecast.forecast_response["list"].each_with_index do |list|
      full_date = Date.parse(list["dt_txt"])
      short_date = "#{full_date.day}/#{full_date.month}"
      next if short_date == today_s

      @summary_forecast[short_date] ||=[]
      @summary_forecast[short_date] << list["main"]["temp"]
    end
    @summary_forecast
  end

  def average_summary
    return @average_summary unless @average_summary.nil?

    @average_summary = {}
    summary_forecast.each do |day, temp|
      @average_summary[day] = (temp.sum / temp.size).round(2)

    end
    @average_summary
  end

  def summary_text
    return nil if @forecast.nil? || current_weather.nil?

    "#{@forecast.weather_response['main']['temp'].to_i}ºC e #{current_weather['description']}"\
    " em #{@forecast.weather_response['name']} em #{today_s}. Média para os próximos dias: #{average_text}"
  end

  def average_text
    return @average_text unless @average_text.nil?

    @average_text = ''
    c = 0
    average_summary.each do |day, avg|
      @average_text += "#{avg.to_i}ºC em #{day}"
      c+=1
      @average_text += (c == average_summary.size) ? "." : ", "
    end
    @average_text
  end

  def today_s
    "#{Date.today.day}/#{Date.today.month}"
  end

end
