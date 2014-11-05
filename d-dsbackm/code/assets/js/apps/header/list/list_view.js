/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("HeaderApp.List", function(List, ContactManager, Backbone, Marionette, $, _){
  List.Header = Marionette.ItemView.extend({
    template: "#header-link",
    tagName: "li",

    events: {
      "click a": "navigate"
    },

    navigate: function(e){
      e.preventDefault();
      this.trigger("navigate", this.model);
    },

    onRender: function(){
      if(this.model.selected){
        // add class so Bootstrap will highlight the active entry in the navbar
        this.$el.addClass("active");
      };
    }
  });

  List.Headers = Marionette.CompositeView.extend({
    template: "#header-template",
    className: "navbar navbar-inverse navbar-fixed-top",
    childView: List.Header,
    childViewContainer: "ul",

    events: {
      "click a.brand": "brandClicked"
    },

    brandClicked: function(e){
      e.preventDefault();
      this.trigger("brand:clicked");
    }
  });
});
