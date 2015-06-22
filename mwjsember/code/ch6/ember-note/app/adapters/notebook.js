/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
import ApplicationAdapter from './application';
import Ember from 'ember';

export default ApplicationAdapter.extend({
  findQuery: function(store, type, query) {
    var keys = Ember.keys(query);
    for(var i = 0; i < keys.length; i++) {
      var key = keys[i];
      var classifiedKey = Ember.String.classify(key);
      query[classifiedKey] = query[key];
      delete query[key];
    }
    return this._super(store, type, query);
  }
});
