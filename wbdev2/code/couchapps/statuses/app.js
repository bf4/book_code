/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/

var couchapp = require('couchapp')
    , path = require('path');

  ddoc = {
      _id: '_design/app'
    , views: {}
    , lists: {}
    , shows: {}
  }

  module.exports = ddoc;

  ddoc.language = "javascript";
  ddoc.rewrites = [
      {from:"/", to:'index.html'}
    , {from:"/api", to:'../../'}
    , {from:"/api/*", to:'../../*'}
    , {from:"/*", to:'*'}
    ];

/** add views/shows/lists below **/
  ddoc.views.byType = {
    map: function(doc) {
      emit(doc.type, null);
    },
    reduce: '_count'
  }
ddoc.views.messages = {
  map: function(doc) {
    emit( doc.type, { title: doc.title, description: doc.description } ) 
  }
}




  couchapp.loadAttachments(ddoc, path.join(__dirname, 'html'));
