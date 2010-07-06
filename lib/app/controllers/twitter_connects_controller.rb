require 'twitter'
require File.join(File.dirname(__FILE__), '..', '..', 'twitter_oauth')

class TwitterConnectsController < ActionController::Base
  include TwitterOauth
  
  def oauth
    oauth = get_oauth
    request_token = oauth.set_callback_url twitter_callback_url
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    
    redirect_to request_token.authorize_url
  end
 
  def callback
    oauth = get_oauth
    oauth.authorize_from_request(session[:rtoken], session[:rsecret], params[:oauth_verifier])
    session[:rtoken] = nil
    session[:rsecret] = nil
    session[:atoken] = oauth.access_token.token
    session[:asecret] = oauth.access_token.secret
    render :file => File.dirname(__FILE__) + '/../views/twitter_connects/callback.html.erb'
  end
  
  def logout
    session[:atoken] = nil
    session[:asecret] = nil
    
    redirect_to TwitterConnect.configuration['logout_url'] || root_url
  end
end
