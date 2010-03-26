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

function _loadTwitterConnect() {
  if (document.getElementsByClassName == undefined) {
    document.getElementsByClassName = function(className) {
      var hasClassName = new RegExp("(?:^|\\s)" + className + "(?:$|\\s)");
      var allElements = document.getElementsByTagName("*");
      var results = [];

      var element;
      for (var i = 0; (element = allElements[i]) != null; i++) {
        var elementClass = element.className;
        if (elementClass && elementClass.indexOf(className) != -1 && hasClassName.test(elementClass))
          results.push(element);
      }

      return results;
    }
  }

  var oauths = document.getElementsByClassName('twitter_oauth');
  for (var i = 0; i < oauths.length; i++) {
    var oauth = oauths[i];
    oauth.onclick = function() {
      TwitterConnect.Twitter.setOauthUrl(oauth.getAttribute('href'));
      TwitterConnect.Twitter.setCallback(oauth.getAttribute('onlogin'));
      TwitterConnect.Twitter.startTwitterConnect();
      return false;
    }
  }
};

_loadSuper = window.onload;
window.onload = (typeof window.onload != 'function') ? _loadTwitterConnect : function() { _loadSuper(); _loadTwitterConnect(); };
