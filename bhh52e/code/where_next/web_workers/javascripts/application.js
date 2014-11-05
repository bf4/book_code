/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var worker = new Worker("javascripts/worker.js");

$("#button").click(function(event){
  worker.postMessage("pragprog");
});


worker.onmessage = function(event){
  var img = $("<img>");
  var link = $("<a>");
  var result = event.data;
  var wrapper;

  link.attr("href", result.videolink);
  img.attr("src", result.thumbnail);
  link.append(img); 
  wrapper = link.wrap("<div>").parent();
  $("#output").append(wrapper);
};

worker.onerror = function(event){
  $("outpout").html("Why do you fail??");
};
