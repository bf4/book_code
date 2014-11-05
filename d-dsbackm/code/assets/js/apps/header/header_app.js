/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("HeaderApp", function(Header, ContactManager, Backbone, Marionette, $, _){
  var API = {
    listHeader: function(){
      Header.List.Controller.listHeader();
    }
  };

  ContactManager.commands.setHandler("set:active:header", function(name){
    ContactManager.HeaderApp.List.Controller.setActiveHeader(name);
  });

  Header.on("start", function(){
    API.listHeader();
  });
});
