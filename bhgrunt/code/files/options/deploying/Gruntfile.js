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
    pkg: grunt.file.readJSON('package.json'),
    copyFiles: {
      options: {
        workingDirectory: 'working',
        manifest: [
          'index.html', 'stylesheets/', 'javascripts/'
        ]
      }
    }
  });
  
  var recursiveCopy = function(source, destination){
    if(grunt.file.isDir(source)){

      grunt.file.recurse(source, function(file){
        recursiveCopy(file, destination);
      });

    }else{
      grunt.log.writeln('Copying ' + source + ' to ' + destination);
      grunt.file.copy(source, destination + '/' + source);  
    }
  }
  
  grunt.registerTask('createFolder', 'Create the working folder', function(){
    grunt.config.requires('copyFiles.options.workingDirectory');    
    grunt.file.mkdir(grunt.config.get('copyFiles.options.workingDirectory'));
  });
  
  grunt.registerTask('clean', 'Deletes the working folder and its contents', function(){
    grunt.config.requires('copyFiles.options.workingDirectory');    
    grunt.file.delete(grunt.config.get('copyFiles.options.workingDirectory'));
  });

  grunt.registerTask('copyFiles', function(){
    var files, workingDirectory;
    this.requiresConfig(this.name + '.options.manifest');
    this.requiresConfig(this.name + '.options.workingDirectory');    
    
    files = this.options().manifest;
    workingDirectory = this.options().workingDirectory;
    
    files.forEach(function(item) { 
      recursiveCopy(item, workingDirectory);
    });
    
    var content = '<%=pkg.name %> version <%= pkg.version %>';
    content = grunt.template.process(content);
    grunt.file.write(workingDirectory + '/version.txt', content);
  });
  
  grunt.registerTask('deploy', 'Deploys files', 
                    ['clean', 'createFolder', 'copyFiles']);

  

}

