/***
 * Excerpted from "Backbone Marionette",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/d-dsbackm for more book information.
***/
Marionette.Region.Dialog = Marionette.Region.extend({
  onShow: function(view){
    this.listenTo(view, "dialog:close", this.closeDialog);

    var self = this;
    this.$el.dialog({
      modal: true,
      title: view.title,
      width: "auto",
      close: function(e, ui){
        self.closeDialog();
      }
    });
  },

  closeDialog: function(){
    this.stopListening();
    this.empty();
    this.$el.dialog("destroy");
  }
});
