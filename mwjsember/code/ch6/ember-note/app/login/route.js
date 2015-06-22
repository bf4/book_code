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
    login: function() {
      var self = this;
      this.store.find('user', {
        name: this.controller.get('name')
      }).then(function(users) {
        if(users.get('length') === 1) {
          var user = users.objectAt(0);
          self.session.set('user',user); //Changed from controllerFor
          self.transitionTo('notebooks', user.get('id'));
        }
        else {
          console.log('unexpected query result');
        }
      });
    } 
  }
});
