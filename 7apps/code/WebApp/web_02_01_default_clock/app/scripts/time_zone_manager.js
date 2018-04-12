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
    },

    savedZones : function(includeCurrent) {
      var zones = [];
      if (includeCurrent) {
        var refDate = new Date();
        var offsetMinutes = refDate.getTimezoneOffset();
        zones.push({
          name: "Current",
          zone_name: "Current",
          offset: -offsetMinutes * 60,
          formatted_offset: this.formatOffsetMinutes(-offsetMinutes)
        });
      }
      return zones;
    },

    formatOffsetMinutes : function(offsetMinutes) {
      var offsetHours = offsetMinutes / 60;
      offsetHours = Math.abs(offsetHours).toString() + ":00";
      if (offsetMinutes < 600) offsetHours = "0" + offsetHours;
      if (offsetMinutes < 0) offsetHours = "-" + offsetHours;
      return offsetHours;
    },

    createClocksIn : function(list) {
      var zones = this.savedZones(true);
      _.each(zones, function(zone) {
        var item = $("<li class='clock'/>");
        $(list).append(item);
      });
    }
  };

  $.app.register("managers.TimeZoneManager", TimeZoneManager);

})(jQuery);

