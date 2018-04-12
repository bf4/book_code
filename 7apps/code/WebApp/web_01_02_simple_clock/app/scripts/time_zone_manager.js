/***
 * Excerpted from "Seven Mobile Apps in Seven Weeks",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/7apps for more book information.
***/
(function($) {

  var TimeZoneManager = {
    fetchTimeZones : function(completion) {
      $.ajax({
        url     : "http://localhost:3000/clock/time_zones",
        headers : { Accept: "application/json" },
        success : function(data) {
          completion(data);
        }
      });
    }
  };

  $.app.register("managers.TimeZoneManager", TimeZoneManager);

})(jQuery);

