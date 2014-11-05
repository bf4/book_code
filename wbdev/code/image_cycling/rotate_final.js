/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
$(function() {
  $('.slideshow').cycle({fx: 'fade'});
  addButtons();
});

var setupClickEvents = function(){
  $('#pause').click(function() { 
    $('.slideshow').cycle('pause');
    toggleControls();
  });
  $('#resume').click(function() { 
    $('.slideshow').cycle('resume'); 
    toggleControls();
  });	
};

var addButtons = function(){
  $('body').append("<span id=\"pause\">Pause</span>");
  $('body').append("<span id=\"resume\">Resume</span>");
  $('#resume').toggle();
  setupClickEvents();
};

var toggleControls = function(){
  $('#pause').toggle();
  $('#resume').toggle();
};
