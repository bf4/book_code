/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
module.exports = function(grunt){
  // Your tasks go here

  grunt.registerTask('default', function(){
    console.log('Hello from Grunt.');
  });
  grunt.registerTask('default', function(){

    grunt.log.writeln('Hello from Grunt.');
  });
  
  grunt.registerTask('greet', function(name){
    grunt.log.writeln('Hi there, ' + name);
  });
  
  grunt.registerTask('addNumbers', function(first, second){
    if(isNaN(Number(first))){
      grunt.warn('The first argument must be a number.');
    }
    var answer = Number(first) + Number(second);
    grunt.log.writeln(first + ' + ' + second + ' is ' + answer);
  });
  
  grunt.registerTask('all', ['default', 'greet:Brian', 'addNumbers:2:3']);
  
  grunt.registerTask('praise', 
                     'Have Grunt say nice things about you.', function(){
    var praise = [
      "You're awesome.",
      "You're the best developer ever!",
      "You are extremely attractive.",
      "Everyone loves you!"
    ]
    var pick = praise[(Math.floor(Math.random() * praise.length))];
    grunt.log.writeln(pick);
    
  });

}

