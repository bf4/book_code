/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("ContactsApp.Edit", function(Edit, ContactManager, Backbone, Marionette, $, _){
  Edit.Contact = ContactManager.ContactsApp.Common.Views.Form.extend({
    initialize: function(){
      this.title = "Edit " + this.model.get("firstName") + " " + this.model.get("lastName");
    },

    onRender: function(){
      if(this.options.generateTitle){
        var $title = $('<h1>', { text: this.title });
        this.$el.prepend($title);
      }

      this.$(".js-submit").text("Update contact");
    }
  });
});
