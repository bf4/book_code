/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var onmessage = function(event) {
  var query = event.data;
  getYoutubeResults(query);
};

var processResults = function(json) {
  var data, result;
  for(var index = 0; index < json.feed.entry.length; index++){
    result = json.feed.entry[index]["media$group"];
    data = {
      thumbnail: result["media$thumbnail"][0]["url"],
      videolink: result["media$content"][0]["url"]
    }
    postMessage(data);
  }  
};

var  getYoutubeResults = function(searchTerm) {
  var callback = "processResults";
  url = "http://gdata.youtube.com/feeds/videos?vq=" + searchTerm + 
        "&alt=json-in-script&max-results=5&callback=" + callback;
  importScripts(url);
};

