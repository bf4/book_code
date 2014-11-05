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
    copyFiles: {
      options: {
        workingDirectory: 'working',
        manifest: [
          'index.html', 'stylesheets/style.css', 'javascripts/app.js'
        ]
      }
    }
  });
  
  grunt.registerTask('createFolder', 'Create the working folder', function(){
    grunt.config.requires('copyFiles.options.workingDirectory');    
	
    grunt.file.mkdir(grunt.config.get('copyFiles.options.workingDirectory'));
  });
  
  grunt.registerTask('clean', 
       'Deletes the working folder and its contents', function(){
    grunt.config.requires('copyFiles.options.workingDirectory');    
	
    grunt.file.delete(grunt.config.get('copyFiles.options.workingDirectory'));
  });
  
  grunt.registerTask('copyFiles', function(){
    var files, workingDirectory;
    
    grunt.config.requires('copyFiles.options.manifest');
    grunt.config.requires('copyFiles.options.workingDirectory');    
    
    files = grunt.config.get('copyFiles.options.manifest');
    workingDirectory = grunt.config.get('copyFiles.options.workingDirectory');
    files.forEach(function(file) { 
      var destination = workingDirectory + '/' + file;
      grunt.log.writeln('Copying ' + file + ' to ' + destination);
      grunt.file.copy(file, destination);
    });
  });

  grunt.registerTask('deploy', 'Deploys files', 
                    ['clean', 'createFolder', 'copyFiles']);
  
}

