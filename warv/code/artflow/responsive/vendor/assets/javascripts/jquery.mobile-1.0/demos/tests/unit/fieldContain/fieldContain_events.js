/***
 * Excerpted from "The Rails View",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
***/
/*
 * mobile dialog unit tests
 */
(function($){
	module('jquery.mobile.fieldContain.js');

	test( "Field container contains appropriate css styles", function(){	
		ok($('#test-fieldcontain').hasClass('ui-field-contain ui-body ui-br'), 'A fieldcontain element must contain styles "ui-field-contain ui-body ui-br"');
	});
	
	test( "Field container will create when inside a container that receives a 'create' event", function(){
		ok( !$("#enhancetest").appendTo(".ui-page-active").find(".ui-field-contain").length, "did not have enhancements applied" );
		ok( $("#enhancetest").trigger("create").find(".ui-field-contain").length, "enhancements applied" );
	});
	
})(jQuery);
