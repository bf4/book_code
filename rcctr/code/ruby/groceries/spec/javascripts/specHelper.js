/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
/*
global.window = global;
global.navigator = {};

require('util/underscore');
require('util/modit');
require('util/moditTest');
require('application');
require('shoppingList');
require('funMenu');

_.extend(exports, global.app);
*/

var jsdom = require("jsdom");

window = jsdom.jsdom("<html><head></head><body></body></html>").createWindow();
global.navigator = {
  userAgent: 'jasmine'
};
global.window = window;
global.document = window.document;
global.location = "http://groceries.com";


beforeEach(function () {
  $('body').empty();
});

require('util/underscore');
require('util/modit');
require('util/moditTest');

require('util/jquery-1.4.2.js');
if (window.$) { 
  global.$ = window.$; 
  global.jQuery = window.jQuery;
}

require('application');
require('shoppingList');
require('ooMenu');
require('user');

_.extend(exports, global.app);
