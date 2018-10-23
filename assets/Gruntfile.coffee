module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')  

  config =
    clean:
      main: ['build']

    copy:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**', '!**/*.js', '**/*.min.js', '!**/*.coffee', '!**/*.scss']
          dest: "build/"
        ]

    coffee:
      main:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.coffee']
          dest: "build/"
          ext: '.js'
        ]
    
    sass:
      compile:
        options:
          style: 'compressed'
          loadPath: require('node-neat').includePaths
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.scss']
          dest: 'build/'
          ext: '.css'
        ]

    cssmin:
      main:
        expand: true
        cwd: 'build/'
        src: ['*.css', '!*.min.css']
        dest: 'build/'
        ext: '.min.css'

    uglify:
      dev:
        options:
          mangle: false
          compress: false
          beautify: true
        files: [{
          expand: true
          cwd: 'src/arquivos/'
          src: ['*.js', '!*.min.js']
          dest: 'build/arquivos/'
          ext: '.min.js'          
        }]        
      dist:
        options:
          mangle: false
        files: [{
          expand: true
          cwd: 'src/arquivos/'
          src: ['*.js', '!*.min.js']
          dest: 'build/arquivos/'
          ext: '.min.js'          
        }]        

    watch:
      options:
        livereload: true
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee']
      sass:
        files: ['src/**/*.scss']
        tasks: ['sass']      
      uglify:
        files: ['src/**/*.js']
        tasks: ['uglify:dev']
      css:
        files: ['build/**/*.css']
      main:
        files: ['src/**/*.html', 'src/**/*.js', 'src/**/*.css']
        tasks: ['copy:main']
      grunt:
        files: ['Gruntfile.coffee']

  tasks =
    # Building block tasks
    build: ['clean', 'copy:main', 'coffee', 'sass', 'uglify:dev']
    min: ['uglify:dist', 'cssmin'] # minifies files

    # Deploy tasks
    dist: ['build', 'min'] # Dist - minifies files
    test: []

    # Development tasks
    default: ['build', 'watch']
    devmin: ['build', 'min'] # Minifies files and serve

  # Project configuration.
  grunt.config.init config

  if grunt.cli.tasks[0] is 'sass'
    grunt.loadNpmTasks 'grunt-contrib-sass'

  else if grunt.cli.tasks[0] is 'coffee'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
  
  else
    grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'
  grunt.registerTask taskName, taskArray for taskName, taskArray of tasks
