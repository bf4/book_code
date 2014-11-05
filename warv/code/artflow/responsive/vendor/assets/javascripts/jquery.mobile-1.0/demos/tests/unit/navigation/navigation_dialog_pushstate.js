/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
(function($) {
	asyncTest( "dialog ui-state should be part of the hash", function(){
		$.testHelper.sequence([
			function() {
				// open the test page
				$.mobile.activePage.find( "a" ).click();
			},

			function() {
				// verify that the hash contains the dialogHashKey
				ok( location.hash.search($.mobile.dialogHashKey) >= 0 );
				start();
			}
		]);
	});
})(jQuery);