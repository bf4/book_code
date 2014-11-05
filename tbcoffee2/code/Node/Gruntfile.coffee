module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-eco')
  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-nodemon')

  grunt.initConfig
    watch:
      coffeeAssets:
        files: 'assets/coffee/*.coffee'
        tasks: ['coffee:compileAssets']
      coffeeServer:
        files: 'src/*.coffee'
        tasks: ['coffee:compileServer']
      eco:
        files: 'assets/templates/*.eco'
        tasks: ['eco:compile']
      css:
        files: 'assets/css/*.css'
        tasks: ['copy:css']
      html:
        files: 'assets/html/*.html'
        tasks: ['copy:html']

    coffee:
      compileAssets:
        expand: true
        flatten: true
        options:
          sourceMap: true
        cwd: 'assets/coffee/'
        src: ['*.coffee']
        dest: 'lib/public/js/'
        ext: '.js'
      compileServer:
        expand: true
        flatten: true
        options:
          sourceMap: true
        cwd: 'src/'
        src: ['*.coffee']
        dest: 'lib/'
        ext: '.js'

    eco:
      compile:
        options:
          basePath: 'assets'
        src: 'assets/templates/*.eco'
        dest: 'lib/public/js/templates.js'

    copy:
      css:
        files: [{
          expand: true
          cwd: 'assets/css/'
          src: ['*.css']
          dest: 'lib/public/css/'
        }]
      html:
        files: [{
          expand: true
          cwd: 'assets/html/'
          src: ['*.html']
          dest: 'lib/public/'
        }]
      bower:
        files: [{
          expand: true
          flatten: true
          cwd: 'bower_components/'
          src: [
            'jquery/dist/jquery.js'
            'underscore/underscore.js'
            'backbone/backbone.js'
          ]
          dest: 'lib/public/js/'
        }]

    nodemon:
      dev:
        script: 'lib/server.js'
        watch: 'lib'
        ext: '*'
        options:
          nodeArgs: ['--debug']

    concurrent:
      dev:
        tasks: ['nodemon', 'watch']
        options:
          logConcurrentOutput: true

  grunt.registerTask('build', ['coffee', 'eco', 'copy'])
  grunt.registerTask('default', ['build', 'concurrent'])
