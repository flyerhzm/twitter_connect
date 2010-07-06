module TwitterOauth
  def get_oauth
    oauth = Twitter::OAuth.new(TwitterConnect.configuration['consumer_token'], TwitterConnect.configuration['consumer_secret'])
  end
end