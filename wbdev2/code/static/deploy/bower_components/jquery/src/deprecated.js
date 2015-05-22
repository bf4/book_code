/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
define([
	"./core",
	"./traversing"
], function( jQuery ) {

// The number of elements contained in the matched element set
jQuery.fn.size = function() {
	return this.length;
};

jQuery.fn.andSelf = jQuery.fn.addBack;

});
