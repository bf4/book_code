/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
ContactManager.module("ContactsApp.Edit", function(Edit, ContactManager, Backbone, Marionette, $, _){
  Edit.Controller = {
    editContact: function(id){
      var loadingView = new ContactManager.Common.Views.Loading({
        title: "Artificial Loading Delay",
        message: "Data loading is delayed to demonstrate using a loading view."
      });
      ContactManager.mainRegion.show(loadingView);

      var fetchingContact = ContactManager.request("contact:entity", id);
      $.when(fetchingContact).done(function(contact){
        var view;
        if(contact !== undefined){
          view = new Edit.Contact({
            model: contact,
            generateTitle: true
          });

          view.on("form:submit", function(data){
            if(contact.save(data)){
              ContactManager.trigger("contact:show", contact.get("id"));
            }
            else{
              view.triggerMethod("form:data:invalid", contact.validationError);
            }
          });
        }
        else{
          view = new ContactManager.ContactsApp.Show.MissingContact();
        }

        ContactManager.mainRegion.show(view);
      });
    }
  };
});
