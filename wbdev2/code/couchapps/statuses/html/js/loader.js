/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
function couchapp_load(scripts) {
  for (var i=0; i < scripts.length; i++) {
    document.write('<script src="'+scripts[i]+'"><\/script>')
  };
};

couchapp_load([
  "http://cdnjs.cloudflare.com/ajax/libs/handlebars.js \
    /2.0.0/handlebars.min.js",
  "http://ajax.googleapis.com/ajax/libs/jquery/2.1.3 \
    /jquery.min.js",
  "https://cdnjs.cloudflare.com/ajax/libs/jquery-browser \
    /0.0.7/jquery.browser.min.js",
  "js/lib/jquery.couch.js"
]);
