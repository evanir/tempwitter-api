# frozen_string_literal: true

# module Twitter
module TwitterForecast
  # module TwitterClient
  # Cria a conexão com a API Twitter
  module TwitterClient
    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV.fetch('TWITTER_CONSUMER_KEY')
        config.consumer_secret     = ENV.fetch('TWITTER_CONSUMER_SECRET')
        config.access_token        = ENV.fetch('TWITTER_ACCESS_TOKEN', nil)
        config.access_token_secret = ENV.fetch('TWITTER_ACCESS_SECRET', nil)
      end
    end
  end
end
