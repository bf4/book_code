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
  actions: {
    addNew: function() {
      var self = this; 
      var user = this.store.createRecord('user', {
        name : this.controller.get('name')
      });
      user.save().then(function() {
        console.log('save successful');
        self.controller.set('message','A new user with the name "' 
          + self.controller.get('name') + '" was added!');
        self.controller.set('name',null);
      }, function() {
        console.log('save failed');
      });
    }
  }
});
