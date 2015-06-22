/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
import Ember from 'ember';

export function initialize(registry, application) {
  var logger = Ember.Object.extend({
    log: function(message) {
      console.log(message);
    }
  });
  application.register('logger:main', logger);
  application.inject('route','logger','logger:main');  
}

export default {
  name: 'logger',
  initialize: initialize
};
