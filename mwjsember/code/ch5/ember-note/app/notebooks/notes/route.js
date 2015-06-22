/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
import Ember from 'ember';

export default Ember.Route.extend({
  model: function(params) {
  	return this.store.find('note', {notebook:params.notebook_id});
  },
  actions: {
    addNote: function() {
      var self = this;
      this.store.find('notebook', 
        this.paramsFor('notebooks.notes').notebook_id).then(
          function(notebook) {
            var note = self.store.createRecord('note', {
              title : self.controller.get('title'),
              notebook: notebook
            });
            note.save().then(function() {
              console.log('save successful');
              self.controller.set('title',null);
              self.refresh();
            }, function() {
              console.log('save failed');
            });
          });
      },
      deleteNote: function(note) {
        console.log('deleting note with title ' + note.get('title'));
        note.deleteRecord();
        note.save();
      }  
    }
});
