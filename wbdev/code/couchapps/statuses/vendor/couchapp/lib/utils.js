/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
exports.prettyDate = function(time){
  
	var date = new Date(time.replace(/-/g,"/").replace("T", " ").replace("Z", " +0000").replace(/(\d*\:\d*:\d*)\.\d*/g,"$1")),
		diff = (((new Date()).getTime() - date.getTime()) / 1000),
		day_diff = Math.floor(diff / 86400);

  if (isNaN(day_diff)) return time;

	return day_diff < 1 && (
			diff < 60 && "just now" ||
			diff < 120 && "1 minute ago" ||
			diff < 3600 && Math.floor( diff / 60 ) + " minutes ago" ||
			diff < 7200 && "1 hour ago" ||
			diff < 86400 && Math.floor( diff / 3600 ) + " hours ago") ||
		day_diff == 1 && "yesterday" ||
		day_diff < 21 && day_diff + " days ago" ||
		day_diff < 45 && Math.ceil( day_diff / 7 ) + " weeks ago" ||
    time;
    // day_diff < 730 && Math.ceil( day_diff / 31 ) + " months ago" ||
    // Math.ceil( day_diff / 365 ) + " years ago";
};
