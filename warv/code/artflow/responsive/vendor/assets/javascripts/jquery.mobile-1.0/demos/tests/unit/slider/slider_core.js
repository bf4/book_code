/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
/*
 * mobile slider unit tests
 */
(function($){
	$.mobile.page.prototype.options.keepNative = "input.should-be-native";

	// not testing the positive case here since's it's obviously tested elsewhere
	test( "slider elements in the keepNative set shouldn't be enhanced", function() {
		same( $("input.should-be-native").siblings("div.ui-slider").length, 0 );
	});
})( jQuery );