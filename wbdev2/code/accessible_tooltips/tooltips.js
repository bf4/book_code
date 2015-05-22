/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
(function($){
  var $definitions = $('.definition');
  $definitions.find('.tooltip').attr('aria-hidden','true');

  function showTip(){
    $(this).find('.tooltip').attr('aria-hidden', 'false');
  }

  function hideTip(){
    $(this).find('.tooltip').attr('aria-hidden', 'true');
  }

  $definitions.on('mouseover focusin', showTip);
  $definitions.on('mouseout focusout', hideTip);
})(jQuery);
