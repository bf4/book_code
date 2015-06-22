/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
export function initialize(container,application) {
   var session = Ember.Object.extend();
   application.register('session:main', session);
   application.inject('adapter', 'session', 'session:main');
   application.inject('route','session','session:main')
}

export default {
  name: 'session',
  initialize: initialize
};
