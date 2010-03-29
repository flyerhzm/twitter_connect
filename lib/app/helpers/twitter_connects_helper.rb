module TwitterConnectsHelper

  def tc_login_button(login_callback, oauth_url, class_name=nil)
    if session[:atoken] and session[:asecret]
      link_to 'Twitter', '#', :onclick => login_callback, :class => "#{class_name}"
    else
      link_to 'Twitter', oauth_url, :onlogin => login_callback, :class => "#{class_name} twitter_oauth"
    end
  end
end
