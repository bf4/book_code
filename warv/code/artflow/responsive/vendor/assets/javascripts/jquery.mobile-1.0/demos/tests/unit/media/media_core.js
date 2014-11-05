/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
/*
 * mobile media unit tests
 */

(function($){
	var cssFn = $.fn.css,
			widthFn = $.fn.width;

	// make sure original definitions are reset
	module('jquery.mobile.media.js', {
		setup: function(){
			$(document).trigger('mobileinit.htmlclass');
		},
		teardown: function(){
			$.fn.css = cssFn;
			$.fn.width = widthFn;
		}
	});

	test( "media query check returns true when the position is absolute", function(){
		$.fn.css = function(){ return "absolute"; };
		same($.mobile.media("screen 1"), true);
	});

	test( "media query check returns false when the position is not absolute", function(){
		$.fn.css = function(){ return "not absolute"; };
		same($.mobile.media("screen 2"), false);
	});

	test( "media query check is cached", function(){
		$.fn.css = function(){ return "absolute"; };
		same($.mobile.media("screen 3"), true);

		$.fn.css = function(){ return "not absolute"; };
		same($.mobile.media("screen 3"), true);
	});


})(jQuery);