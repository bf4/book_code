/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
exports.get = function(db, docid, setFun, getFun) {
  db.openDoc(docid, {
    success : function(doc) {
      getFun(doc.cache);
    },
    error : function() {
      setFun(function(cache) {
        db.saveDoc({
          _id : docid,
          cache : cache
        });
        getFun(cache);
      });
    }
  });
};

exports.clear = function(db, docid) {
  db.openDoc(docid, {
    success : function(doc) {
      db.removeDoc(doc);
    },
    error : function() {}
  });
};
