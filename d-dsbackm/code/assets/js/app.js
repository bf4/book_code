/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
var ContactManager = new Marionette.Application();

ContactManager.addRegions({
  headerRegion: "#header-region",
  mainRegion: "#main-region",
  dialogRegion: Marionette.Region.Dialog.extend({
    el: "#dialog-region"
  })
});

ContactManager.navigate = function(route,  options){
  options || (options = {});
  Backbone.history.navigate(route, options);
};

ContactManager.getCurrentRoute = function(){
  return Backbone.history.fragment
};

ContactManager.on("start", function(){
  if(Backbone.history){
    Backbone.history.start();

    if(this.getCurrentRoute() === ""){
      ContactManager.trigger("contacts:list");
    }
  }
});
