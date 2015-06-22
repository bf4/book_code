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
    return this.store.find('notebook',{user: params.user_id});
  },
  actions: {
      addNotebook: function() {
        var self = this; 
        var notebook = this.store.createRecord('notebook', {
          title: this.controller.get('title'),
          user: this.controllerFor('application').get('user')
        });
        notebook.save().then(function() {
          console.log('save successful');
          self.controller.set('title',null);
          self.refresh();
        }, function() {
          console.log('save failed');
        });
      }
  }

});
