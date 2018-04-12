/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
(function($) {

  var Clock = {
    tick : function() {
      var date = new Date();
      $(".clock").text(date.getHours() +
                         ":" + this.zeroPad(date.getMinutes()) +
                         ":" + this.zeroPad(date.getSeconds()));
    },

    zeroPad : function(number) {
      var s = number.toString();
      var formattedNumber = (s.length > 1) ? s : "0" + s;
      return formattedNumber;
    }
  };

  $.app.register("models.Clock", Clock);

})(jQuery);

