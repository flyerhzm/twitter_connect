if (!TwitterConnect) {
  var TwitterConnect = {};
}
TwitterConnect.Twitter = new function() {
  var self = this;
 
  this.setOauthUrl = function(url) {
    self.oauth_url = url;
  }
 
  this.setCallback = function(callback) {
    self.callback = callback;
  }
  
  this.startTwitterConnect = function() {
    var popupParams = 'location=0,status=0,width=800,height=400';
    self._twitterWindow = window.open(self.oauth_url, 'twitterConnectWindow', popupParams);
    self._twitterInterval = window.setInterval(self.completeTwitterConnect, 500);
  }

  this.completeTwitterConnect = function() {
    if (self._twitterWindow.closed) {
      window.clearInterval(self._twitterInterval);
      eval(self.callback);
    }
  }
};

$(document).ready(function() {
  $('.twitter_oauth').click(function() {
    TwitterConnect.Twitter.setOauthUrl($(this).attr('href'));
    TwitterConnect.Twitter.setCallback($(this).attr('onlogin'));
    TwitterConnect.Twitter.startTwitterConnect();
    return false;
  });
});