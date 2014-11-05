/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
$(function() {
  $('#slideshow').cycle({fx: 'fade'});
  setupButtons();
});
var setupButtons = function(){
  var slideShow = $('#slideshow');

  var pause = $('<span id="pause">Pause</span>');
  pause.click(function() { 
   slideShow.cycle('pause');
    toggleControls();
  }).insertAfter(slideShow);
  
  var resume = $('<span id="resume">Resume</span>');
  resume.click(function() { 
    slideShow.cycle('resume'); 
    toggleControls();
  }).insertAfter(slideShow);

  resume.toggle();
};

var toggleControls = function(){
	$('#pause').toggle();
	$('#resume').toggle();
};

