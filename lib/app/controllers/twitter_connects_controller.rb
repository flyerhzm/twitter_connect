class TwitterConnectsController < ActionController::Base
  def oauth
    oauth = get_oauth
    rtoken  = oauth.request_token.token
    rsecret = oauth.request_token.secret
   
    oauth.set_callback_url callback_twitter_connects_path
    redirect_to oauth.request_token.authorize_url
  end
 
  def callback
    session[:oauth_token] = params[:oauth_token]
    session[:oauth_verifier] = params[:oauth_verifier]
    oauth = get_oauth
    oauth.authorize_from_access(params[:oauth_token], params[:oauth_verifier])
  end

  private
    def get_oauth
      oauth = Twitter::OAuth.new(Thread.current[:tc_config]['consumer_token'], Thread.current[:tc_config]['consumer_secret'])
    end
end
