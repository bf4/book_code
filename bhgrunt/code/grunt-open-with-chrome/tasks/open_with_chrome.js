/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
'use strict';

module.exports = function(grunt) {
  var chromeLauncher = require('./lib/chrome_launcher.js').init(grunt);
  grunt.registerTask('open', 'Opens the file or URL with Chrome', 
    function(file){  
      var done = this.async();
      chromeLauncher.open(file, done);
    }
  );

};

