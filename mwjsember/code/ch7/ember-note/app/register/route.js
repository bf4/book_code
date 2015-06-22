/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
import Ember from 'ember';
import ValidationFunctions from 'ember-note/mixins/validation-functions';

export default Ember.Route.extend(ValidationFunctions,{
  actions : {
    addNew : function() {
      var name = this.controller.get('name');
      if(this.isValidEmail(name))

       {
        var self = this; 
        var user = this.store.createRecord('user', {
          name : name
        });
        user.save().then(function() {
          console.log('save successful');
          self.controller.set('message',
            'A new user with the name "' + name + '" was added!');
          self.controller.set('name',null);
        }, function() {
          console.log('save failed');
        });
      }
      else {
        alert('Invalid email address.');
      }
    }
  }
});
