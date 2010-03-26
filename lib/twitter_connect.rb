module TwitterConnect
  @consumer_token = nil
  @consumer_secret = nil
  
  class <<self
    def load_configuration(twitter_yaml_file)
      return false unless File.exist?(twitter_yaml_file)
      @configuration = YAML.load(File.read(twitter_yaml_file))[RAILS_ENV]
    end

    def configuration
      @configuration
    end
  end
end

require 'app/controllers/twitter_connects_controller'
require 'app/helpers/twitter_connects_helper'

module ActionController
  class Base
    helper TwitterConnectsHelper
  end
end

unless File.exist?(File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
  File.copy(File.join(File.dirname(__FILE__), "/public/javascripts/twitter_connect.js"), File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
end
