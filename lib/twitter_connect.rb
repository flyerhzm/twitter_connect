module TwitterConnect
  @consumer_token = nil
  @consumer_secret = nil
  
  class <<self
    def load_configuration(twitter_yaml_file)
      return false unless File.exist?(twitter_yaml_file)
      @configuration = YAML.load_file(twitter_yaml_file)[RAILS_ENV]
    end

    def configuration
      @configuration
    end
    
    def init
      unless File.exist?(File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
        File.copy(File.join(File.dirname(__FILE__), "/public/javascripts/twitter_connect.js"), File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
      end
    
      load_configuration("#{Rails.root}/config/twitter.yml")
    end
  end
end

require 'app/controllers/twitter_connects_controller'
require 'app/helpers/twitter_connects_helper'

module ActionController
  class Base
    helper TwitterConnectsHelper
    
    def set_twitter_client
      begin
        oauth = Twitter::OAuth.new(TwitterConnect.configuration['consumer_token'], TwitterConnect.configuration['consumer_secret'])
        oauth.authorize_from_access(session[:atoken], session[:asecret])
        @twitter_client = Twitter::Base.new(oauth)
      rescue Twitter::Unauthorized
        redirect_to TwitterConnect.configuration['logout_url'] || root_url
      end
    end
    
    attr_reader :twitter_client
  end
end

require 'ftools'
if defined? Rails::Railtie
  class TwitterRailtie < Rails::Railtie
    initializer "twitter_connect.init_task" do |app|
      TwitterConnect.init
    end
  end
else
  TwitterConnect.init
end

