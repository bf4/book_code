/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
(function($) {
	asyncTest( "nested pages hash key is always in the hash on default page with no id (replaceState) ", function(){
		$.testHelper.pageSequence([
			function(){
				// Click on the link of the third li element
				$('.ui-page-active li:eq(2) a:eq(0)').click();
			},

			function(){
				ok( location.hash.search($.mobile.subPageUrlKey) >= 0 );
				start();
			}
		]);
	});
})(jQuery);