# TwitterConnect

facebook connect style twitter oauth

## Demo

[http://twitter-connect.heroku.com](http://twitter-connect.heroku.com)

## Install

<pre><code>rails plugin install git://github.com/flyerhzm/twitter_connect.git</code></pre>

## Usage

1 define <code>config/twitter.yml</code>
<pre><code>
development:
  consumer_token: 
  consumer_secret: 
  logout_url: 
production:
  consumer_token: 
  consumer_secret: 
  logout_url:
</code></pre>
consumer_token and consumer_secret are fetched after you registered a twitter app.
logout_url is where the app go to when user logs out or the session expired.

2 define routes
<pre><code>
match '/twitter_oauth', :to => "twitter_connects#oauth", :as => :twitter_oauth
match '/twitter_callback', :to => "twitter_connects#callback", :as => :twitter_callback
match '/twitter_logout', :to => "twitter_connects#logout", :as => :twitter_logout
</code></pre>

3 add javascript to html header
<pre><code>
<%= javascript_include_tag 'twitter_connect' %>
</code></pre>

4 add twitter login link on view page
<pre><code>
<%= tc_login_button "window.location.reload()" %>
</code></pre>
Or:
<pre><code>
<%= tc_login_button "window.location.href = '#{tweets_path}'", :class_name => 'twitter_button' %>
</code></pre>
<code>tc_login_button</code> has two parameters, first is the callback javascript, second is customized parameter :text or :class_name

5 add twitter logout link on view page
<pre><code>
<%= link_to "Logout from Twitter", twitter_logout_path %>
</code></pre>


Copyright (c) 2010 [Richard Huang], released under the MIT license
