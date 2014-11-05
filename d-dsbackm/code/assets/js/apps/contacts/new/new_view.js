/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("ContactsApp.New", function(New, ContactManager, Backbone, Marionette, $, _){
  New.Contact = ContactManager.ContactsApp.Common.Views.Form.extend({
    title: "New Contact",

    onRender: function(){
      this.$(".js-submit").text("Create contact");
    }
  });
});
