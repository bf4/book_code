/***
 * Excerpted from "Deliver Audacious Web Apps with Ember 2",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/mwjsember for more book information.
***/
import DS from 'ember-data';

export default DS.RESTSerializer.extend({
  normalizeHash: {
    notebooks: function(hash) {
      hash.title = hash.Title;
      delete hash.Title;
      hash.user = hash.User;
      delete hash.User;
      return hash;
    }
  },
  serialize: function(snapshot, options) {
    var json = {
      Title: snapshot.attr('title'),
      User: snapshot.belongsTo('user').get('id')
    }
    return json;
  },
});
