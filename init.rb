twitter_config = "#{RAILS_ROOT}/config/twitter.yml"

require 'twitter_connect'
TwitterConnect.load_configuration(twitter_config)
