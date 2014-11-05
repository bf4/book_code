/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("ContactsApp.Show", function(Show, ContactManager, Backbone, Marionette, $, _){
  Show.MissingContact = Marionette.ItemView.extend({
    template: "#missing-contact-view"
  });

  Show.Contact = Marionette.ItemView.extend({
    template: "#contact-view",

    events: {
      "click a.js-edit": "editClicked"
    },

    editClicked: function(e){
      e.preventDefault();
      this.trigger("contact:edit", this.model);
    }
  });
});
