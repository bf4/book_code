/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
module.exports.init = function(grunt){
  
  // the object we'll return
  var exports = {};
  
  
  // creates the command
  var createCommand = function(file){
    // booleans for the OS we're using
    var command = "";
    var linux = !!process.platform.match(/^linux/);
    var windows = !!process.platform.match(/^win/);
    if(windows){
      command = 'start chrome ' + file;
    }else if (linux){
      command = 'google-chrome "' + file + '"';
    }else{
      command = 'open -a "Google Chrome" ' + file;
    }
    return(command);
  };
  
  // opens Chrome and loads the file or URL passed in
  exports.open = function(file, done){
    var command, process, exec;
    command = createCommand(file);
    grunt.log.writeln('Running command: ' + command);

    exec = require('child_process').exec;
    process = exec(command, function (error, stdout, stderr) {
      if (error) {
        if(error.code !== 0){
          grunt.warn(stderr);
          grunt.log.writeln(error.stack);
        }
      }
      done();
    });
  };
 
  // returns the object
  return(exports);
};
