/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
  $("#contacts li").click(function(event){
    var email, origin;
    email = $(this).find(".email").html();
    origin = "http://localhost:3000/index.html";
    if(window.postMessage){
      window.parent.postMessage(email, origin); 
    }
  });
