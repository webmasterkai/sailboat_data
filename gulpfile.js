(function() {
  var browserSync, gulp, jade, less, path;

  path = require('path');

  gulp = require('gulp');

  browserSync = require('browser-sync');

  jade = require('gulp-jade');

  less = require('gulp-less');

  gulp.task("browser-sync", function() {
    browserSync.init("public/**", {
      server: {
        baseDir: "public"
      },
      injectChanges: false,
      logConnections: true,
      ghostMode: {
        clicks: true,
        scroll: true,
        location: true
      }
    });
  });

  gulp.task("templates", function() {
    var data;
    data = {
      title: 'Fancy Title!'
    };
    gulp.src("templates/*.jade").pipe(jade({
      locals: data
    })).pipe(gulp.dest("./public/"));
  });

  gulp.task('styles', function() {
    gulp.src("styles/*.less").pipe(less({
      paths: [path.join(__dirname, "less", "includes")]
    })).pipe(gulp.dest("./public"));
  });

  gulp.task("default", ['styles', 'templates', 'browser-sync'], function() {
    gulp.watch("templates/*.jade", ["templates"]);
    gulp.watch("styles/*.less", ["styles"]);
  });

}).call(this);
