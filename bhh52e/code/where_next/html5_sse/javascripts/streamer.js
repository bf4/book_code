/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var createMessageListeners = function(){
  var messageSource = new EventSource("/stream");
  
  messageSource.addEventListener("message",  function(event){
    document.getElementById("message").innerHTML = event.data;
  }, false);
  
  messageSource.addEventListener("error",  function(event){
    console.log("got an error");
  }, false);
  
  messageSource.addEventListener("open",  function(event){
    console.log("got a connection");
  }, false);
  
}

  createMessageListeners();
