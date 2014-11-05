/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
exports.ddoc = function(ddoc) {
  // only return the parts of the app that we use
  var i, j, path, key, obj, ref, out = {},
    resources = ddoc.couchapp && ddoc.couchapp.load && ddoc.couchapp.load.app || [];
  for (i=0; i < resources.length; i++) {
    path = resources[i].split('/');
    obj = ddoc;
    ref = out;
    for (j=0; j < path.length; j++) {
      key = path[j];
      ref[key] = ref[key] || {};
      if (j < path.length - 1) {
        obj = obj[key];
        ref = ref[key];
      }
    };
    ref[key] = obj[key];
  };
  return out;
};
