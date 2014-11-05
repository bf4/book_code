/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("AboutApp", function(AboutApp, ContactManager, Backbone, Marionette, $, _){
  AboutApp.Router = Marionette.AppRouter.extend({
    appRoutes: {
      "about" : "showAbout"
    }
  });

  var API = {
    showAbout: function(){
      AboutApp.Show.Controller.showAbout();
      ContactManager.execute("set:active:header", "about");
    }
  };

  ContactManager.on("about:show", function(){
    ContactManager.navigate("about");
    API.showAbout();
  });

  ContactManager.addInitializer(function(){
    new AboutApp.Router({
      controller: API
    });
  });
});
