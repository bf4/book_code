/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("HeaderApp.List", function(List, ContactManager, Backbone, Marionette, $, _){
  List.Controller = {
    listHeader: function(){
      var links = ContactManager.request("header:entities");
      var headers = new List.Headers({collection: links});

      headers.on("brand:clicked", function(){
        ContactManager.trigger("contacts:list");
      });

      headers.on("childview:navigate", function(childView, model){
        var trigger = model.get("navigationTrigger");
        ContactManager.trigger(trigger);
      });

      ContactManager.headerRegion.show(headers);
    },

    setActiveHeader: function(headerUrl){
      var links = ContactManager.request("header:entities");
      var headerToSelect = links.find(function(header){ return header.get("url") === headerUrl; });
      headerToSelect.select();
      links.trigger("reset");
    }
  };
});
