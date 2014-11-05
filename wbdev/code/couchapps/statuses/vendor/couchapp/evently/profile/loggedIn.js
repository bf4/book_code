/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
function(e, r) {
  var userCtx = r.userCtx;
  var widget = $(this);
  // load the profile from the user doc
  var db = $.couch.db(r.info.authentication_db);
  var userDocId = "org.couchdb.user:"+userCtx.name;
  db.openDoc(userDocId, {
    success : function(userDoc) {
      var profile = userDoc["couch.app.profile"];
      if (profile) {
        // we copy the name to the profile so it can be used later
        // without publishing the entire userdoc (roles, pass, etc)
        profile.name = userDoc.name;
        $$(widget).profile = profile;
        widget.trigger("profileReady", [profile]);
      } else {
        widget.trigger("noProfile", [userCtx]);
      }
    }
  });
}
