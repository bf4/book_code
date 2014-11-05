/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
function() {
  var elem = $(this);
  $$(this).userCtx = null;
  $.couch.session({
    success : function(r) {
      var userCtx = r.userCtx;
      if (userCtx.name) {
        elem.trigger("loggedIn", [r]);
      } else if (userCtx.roles.indexOf("_admin") != -1) {
        elem.trigger("adminParty");
      } else {
        elem.trigger("loggedOut");
      };
    }
  });
}