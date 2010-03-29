module TwitterConnectsHelper

  def tc_login_button(login_callback, options={})
    if session[:atoken] and session[:asecret]
      link_to options[:text] || 'Sign in with Twitter', '#', :onclick => login_callback, :class => "#{options[:class_name]}"
    else
      link_to options[:text] || 'Sign in with Twitter', oauth_url, :onlogin => login_callback, :class => "#{options[:class_name]} twitter_oauth"
    end
  end
end