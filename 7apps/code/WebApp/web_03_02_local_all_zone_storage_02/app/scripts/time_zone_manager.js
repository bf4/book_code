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

    savedTimeZones : [],

    initialize : function() {
      if (!navigator.onLine) {
        this.loadLocalTimeZones();
      } else {
        var completion = _.bind(function(zones) {
          this.storeTimeZonesLocally(zones);
        }, this);
        this.fetchTimeZones(completion);
      }
    },

    fetchTimeZones : function(completion) {
      var successFunction = _.bind(function(data) {
        this.zonesLoaded(data);
        if (completion) completion(data);
      }, this);
      var errorFunction = _.bind(function() {
        this.loadLocalTimeZones();
      }, this);

      $.ajax({
        url     : "http://localhost:3000/clock/time_zones",
        headers : { Accept: "application/json" },
        success : successFunction,
        error   : errorFunction
      });
    },

    loadLocalTimeZones : function() {
      var localZones = localStorage.allTimeZones;
      if (localZones) {
        this.zonesLoaded(JSON.parse(localZones));
      } else {
        // Inform user that no timezone data is available
      }
    },

    storeTimeZonesLocally : function(zones) {
      localStorage.allTimeZones = JSON.stringify(zones);
    },

    zonesLoaded : function(zones) {
      this.timeZones = zones;
    },

    allZones : function() {
      return this.timeZones;
    },

    saveZoneAtIndex : function(index) {
      var zone = this.timeZones[index];
      this.savedTimeZones.push(zone);
    },

    deleteZoneAtIndex : function(index) {
      this.savedTimeZones.splice(index, 1);
    },

    savedZones : function(includeCurrent) {
      var zones = [].concat(this.savedTimeZones);
      if (includeCurrent) {
        var refDate = new Date();
        var offsetMinutes = refDate.getTimezoneOffset();
        zones.unshift({
          name: "Current",
          zone_name: "Current",
          offset: -offsetMinutes * 60,
          formatted_offset: this.formatOffsetMinutes(-offsetMinutes),
          isCurrent : true
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
    }

  };

  $.app.register("managers.TimeZoneManager", TimeZoneManager);

})(jQuery);

