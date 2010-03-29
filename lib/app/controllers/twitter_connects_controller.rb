class TwitterConnectsController < ActionController::Base
  def oauth
    oauth = get_oauth
    request_token = oauth.set_callback_url callback_url
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    
    redirect_to request_token.authorize_url
  end
 
  def callback
    oauth = get_oauth
    oauth.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    session[:rtoken] = nil
    session[:rsecret] =nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret
    render :file => File.dirname(__FILE__) + '/../views/twitter_connects/callback.html.erb'
  end

  private
    def get_oauth
      oauth = Twitter::OAuth.new(TwitterConnect.configuration['consumer_token'], TwitterConnect.configuration['consumer_secret'])
    end
end
