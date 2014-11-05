/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
(function() {
  var handleEventSourceRequest;
  handleEventSourceRequest = function(request, response) {
    var interval, messages;
    console.log("A request has been made to get the stream.");
    response.writeHead(200, {
      "Content-Type": "text/event-stream;charset=UTF-8",
      "Cache-Control": "no-cache",
      "Connection": "keep-alive"
    });
    response.write("retry: 10000\n");
    response.write("event: connected\n");
    response.write("data: Connection established\n\n");
    messages = ["We are bringing even more awesomeness to you!", "Check out AwesomeComf on Twitter", "Are you ready to be even more awesome?", "Don't be awesful. Be awesome instead!"];
    return interval = setInterval(function() {
      var message;
      message = "data: " + messages[Math.floor(Math.random() * messages.length)] + "\n\n";
      console.log(message);
      return response.write(message);
    }, 5000);
  };
  module.exports = handleEventSourceRequest;
}).call(this);
