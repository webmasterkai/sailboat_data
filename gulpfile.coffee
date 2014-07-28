path = require 'path'

gulp = require 'gulp'

browserSync = require 'browser-sync'

jade = require 'gulp-jade'
less = require 'gulp-less'

gulp.task "browser-sync", ->
  browserSync.init "public/**",
    server:
      baseDir: "public" # Change this to your web root dir
    injectChanges: false
    logConnections: true
    ghostMode:
      clicks: true
      scroll: true
      location: true
  return

gulp.task "templates", ->
  data =
    title: 'Fancy Title!'

  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./public/")
    # .pipe browserSync.reload({stream:true, once: true})
  return

gulp.task 'styles', ->
  gulp.src("styles/*.less")
    .pipe less(paths: [path.join(__dirname, "less", "includes")])
    .pipe gulp.dest("./public")
  return


gulp.task "default", ['styles', 'templates', 'browser-sync'], ->
  gulp.watch "templates/*.jade", ["templates"]
  gulp.watch "styles/*.less", ["styles"]
  return
