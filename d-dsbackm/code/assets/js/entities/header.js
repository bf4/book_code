/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("Entities", function(Entities, ContactManager, Backbone, Marionette, $, _){
  Entities.Header = Backbone.Model.extend({
    initialize: function(){
      var selectable = new Backbone.Picky.Selectable(this);
      _.extend(this, selectable);
    }
  });

  Entities.HeaderCollection = Backbone.Collection.extend({
    model: Entities.Header,

    initialize: function(){
      var singleSelect = new Backbone.Picky.SingleSelect(this);
      _.extend(this, singleSelect);
    }
  });

  var initializeHeaders = function(){
    Entities.headers = new Entities.HeaderCollection([
      { name: "Contacts", url: "contacts", navigationTrigger: "contacts:list" },
      { name: "About", url: "about", navigationTrigger: "about:show" }
    ]);
  };

  var API = {
    getHeaders: function(){
      if(Entities.headers === undefined){
        initializeHeaders();
      }
      return Entities.headers;
    }
  };

  ContactManager.reqres.setHandler("header:entities", function(){
    return API.getHeaders();
  });
});
