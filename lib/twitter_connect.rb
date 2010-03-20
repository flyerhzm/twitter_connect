module TwitterConnect
  @consumer_token = nil
  @consumer_secret = nil
  
  class <<self
    def load_configuration(twitter_yaml_file)
      return false unless File.exist?(twitter_yaml_file)
      @twitter_configuration = YAML.load(File.read(twitter_yaml_file))
      if defined? RAILS_ENV
        @twitter_configuration = @twitter_configuration[RAILS_ENV]
      end
      Thread.current[:tc_config] = @twitter_configuration unless Thread.current[:tc_config]
    end
  end
end

%w{ controllers helpers views }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

unless File.exist?(File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
  File.copy(File.join(File.dirname(__FILE__), "/public/javascripts/twitter_connect.js"), File.join(Rails.root, "/public/javascripts/twitter_connect.js"))
end
