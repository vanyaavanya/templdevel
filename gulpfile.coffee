###

    TEMPLDEVEL

TODO:  Попробовать использовать async parallel для запуска сервера и перезагрузки браузера после обработки файлов

###

gulp      = require 'gulp'
connect   = require 'gulp-connect'
debug     = require 'gulp-debug'
stylus    = require 'gulp-stylus'
nib       = require 'nib'
jade      = require 'gulp-jade'
data      = require 'gulp-data'
util      = require 'gulp-util'
fakedata  = require './fakedata'

gulp.task 'jade', ->
  gulp.src 'jade/*.jade'
    .pipe data fakedata
    .pipe do jade
    .on 'error', (err) -> 
      util.log "JADE ERROR \n" + err.message
      this.emit('end');
    .pipe debug title: 'Jade files:'
    .pipe gulp.dest 'dist'
    .pipe do connect.reload

gulp.task 'stylus', ->
  gulp.src 'stylus/*.styl'
    .pipe stylus( use: [nib()], import: ['nib'])
    .on 'error', (err) -> 
      util.log "STYLUS ERROR: \n" + err.message
      this.emit('end')
    .pipe debug title: 'Stylus files:'
    .pipe gulp.dest 'dist/css/'
    .pipe do connect.reload

gulp.task 'fakedata', ->
  util.log util.colors.blue '--- Fakedata changed, reload server! ---'
  do util.beep

gulp.task 'connect', ->
  connect.server
    port: 1337
    livereload: on
    root: './dist'

gulp.task 'watch', ->
  gulp.watch 'stylus/*.styl',  ->
        setTimeout ->
            gulp.start 'stylus'
        , 300
  gulp.watch 'jade/*.jade', ->
        setTimeout ->
            gulp.start 'jade'
        , 300
  gulp.watch 'fakedata.coffee', ->
        setTimeout ->
            gulp.start 'fakedata'
        , 300

gulp.task 'default', ['jade', 'stylus', 'connect', 'watch']

process.on 'uncaughtException', (err) ->
  util.log util.colors.red 'uncaughtException ' + err