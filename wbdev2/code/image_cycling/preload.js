/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
(function($){
  var images = [
    '<img src="images/lake-bench-slide.jpg">',
    '<img src="images/old-building-slide.jpg">',
    '<img src="images/oldbarn-slide.jpg">',
    '<img src="images/streetsign-with-highlights-slide.jpg">',
    '<img src="images/water-stairs-slide.jpg">'
  ];

  $('#slideshow').cycle(
    {
      fx: 'fade',
      load: true,
      progressive: images
    }
  );
})(jQuery);
