/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
/*
 * mobile widget unit tests
 */
(function($){
	var widgetInitialized = false;

	module( 'jquery.mobile.widget.js' );

	$( "#foo" ).live( 'pageinit', function(){
		// ordering sensitive here, the value has to be set after the call
		// so that if the widget factory says that its not yet initialized,
		// which is an exception, the value won't be set
		$( "#foo-slider" ).slider( 'refresh' );
		widgetInitialized = true;
	});

	test( "page is enhanced before init is fired", function() {
		ok( widgetInitialized );
	});
})( jQuery );