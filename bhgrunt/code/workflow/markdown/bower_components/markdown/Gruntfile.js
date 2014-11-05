/***
 * Excerpted from "Automate with Grunt",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgrunt for more book information.
***/
module.exports = function(grunt) {

  var pkg = grunt.file.readJSON('package.json');

  grunt.initConfig({
    pkg: pkg,
    env: process.env,

    node_tap: {
      default_options: {
        options: {
          outputType: 'failures',
          outputTo: 'console'
        },
        files: {
          'tests': ['./test/*.t.js']
        }
      }
    },

    jshint: {
      files: ['Gruntfile.js', 'src/**/*.js', 'test/**/*.js'],
      options: {
        "browser": false,
        "maxerr": 100,
        "node": true,
        "camelcase": false,
        "curly": false,
        "eqeqeq": true,
        "eqnull": true,
        "forin": false,
        "globals": {
          "define": true,
          "print": true,
          "uneval": true,
          "window": true
        },
        "immed": true,
        "indent": 2,
        "latedef": true,
        "laxbreak": true,
        "laxcomma": true,
        "lastsemic": true,
        "loopfunc": true,
        "noarg": true,
        "newcap": true,
        "plusplus": false,
        "quotmark": "true",
        "regexp": true,
        "shadow": true,
        "strict": false,
        "sub": true,
        "trailing": true,
        "undef": true,
        "unused": false,
        ignores: ['.git', 'node_modules']
      }
    },

    build: {
      web: {
        dest: "dist/markdown.js",
        minimum: ["parser"],
        removeWith: ['dialects/gruber'],
        startFile: "inc/header.js",
        endFile: "inc/footer-web.js"
      },
      node: {
        dest: "lib/markdown.js",
        minimum: ["parser"],
        removeWith: ['dialects/gruber'],
        startFile: "inc/header.js",
        endFile: "inc/footer-node.js"
      }
    },

    uglify: {
      my_target: {
        files: {
          'dist/markdown.min.js': ['dist/markdown.js']
        }
      }
    }

  });

  grunt.registerTask('all', ['test', 'build', 'uglify']);
  grunt.registerTask('default', ['all']);
  grunt.registerTask('test', 'Runs all tests and linting', ['node_tap', 'jshint']);
  grunt.loadNpmTasks('grunt-node-tap');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadTasks("inc/tasks");
};
