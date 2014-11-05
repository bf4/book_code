/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
/*
 * mobile page unit tests
 */
(function($){
	var libName = 'jquery.mobile.page.js';

	module(libName);

	test( "nested header anchors aren't altered", function(){
		ok(!$('.ui-header > div > a').hasClass('ui-btn'));
	});

	test( "nested footer anchors aren't altered", function(){
		ok(!$('.ui-footer > div > a').hasClass('ui-btn'));
	});

	test( "nested bar anchors aren't styled", function(){
		ok(!$('.ui-bar > div > a').hasClass('ui-btn'));
	});

	test( "unnested footer anchors are styled", function(){
		ok($('.ui-footer > a').hasClass('ui-btn'));
	});

	test( "unnested footer anchors are styled", function(){
		ok($('.ui-footer > a').hasClass('ui-btn'));
	});

	test( "unnested bar anchors are styled", function(){
		ok($('.ui-bar > a').hasClass('ui-btn'));
	});

	test( "no auto-generated back button exists on first page", function(){
		ok( !$(".ui-header > :jqmData(rel='back')").length );
	});
})(jQuery);
