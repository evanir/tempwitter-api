class TwitterClient

  def initialize

  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_CONSUMER_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_CONSUMER_SECRET")
      config.access_token        = ENV.fetch("TWITTER_ACCESS_TOKEN", nil)
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_SECRET", nil)
    end
  end

end
