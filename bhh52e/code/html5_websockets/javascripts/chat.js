/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var setupChat = function(){
 // change this to the IP address of the websocket server
 var webSocket = new WebSocket('ws://192.168.1.2:9394/');
 
 webSocket.onopen = function(event){
   $('#chat').append('<br>Connected to the server');
 };
 
 webSocket.onmessage = function(event){
   $('#chat').append("<br>" + event.data);
   $('#chat').animate({scrollTop: $('#chat').height()}); 
 };
 
 webSocket.onclose = function(event){
   $("#chat").append('<br>Connection closed');
 };

 
  $("form#chat_form").submit(function(e){
    e.preventDefault();
    var textfield = $("#message");
    webSocket.send(textfield.val());
    textfield.val("");
  });

  $("form#nick_form").submit(function(e){
    e.preventDefault();
    var textfield = $("#nickname");
    webSocket.send("/nick " + textfield.val());
  });
};



Modernizr.load(
  {
    test: Modernizr.websockets,
    nope: 
      {
       "swfobject" : "web-socket-js/swfobject.js",
       "websocket" : "web-socket-js/web_socket.js"
      },
    callback: function(url, result, key){
      if (!result){
        if(key === "swfobject"){
          WEB_SOCKET_SWF_LOCATION = "web-socket-js/WebSocketMain.swf";
          WEB_SOCKET_DEBUG = true;
        }
      }      
    },
    complete: function(){
      setupChat();
    }
  }
);



