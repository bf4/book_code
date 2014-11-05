/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
module.exports = function(grunt){
  
  grunt.config.init({
    build: {
      angular: {
        src: ['bower_components/angular/angular.js',
              'bower_components/angular-resource/angular-resource.js'],
        dest: 'dist/angular.js'
      },
      angularWithjQuery: {
        src: ['bower_components/jquery/dist/jquery.js',
              'bower_components/angular/angular.js',
              'bower_components/angular-resource/angular-resource.js'],
        dest: 'dist/jquery-angular.js'
      }
    }
  });

  grunt.registerMultiTask('build', 'Concatenate files.', function() {
    var output = '';
    this.files.forEach(function(filegroup) { 
      sources = filegroup.src.map(function(file){ 
        return(grunt.file.read(file));
      });
      output = sources.join(';');
      grunt.file.write(filegroup.dest, output);
    });   
  });
}

