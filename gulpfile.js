(function() {
  var bd, browserSync, browserify, clean, coffeeify, data, fs, gulp, jade, less, path, r, rename, runSequence, source, watchify, yaml, zopfli;

  path = require('path');

  fs = require('fs-extra');

  gulp = require('gulp');

  r = require('request');

  yaml = require('js-yaml');

  browserSync = require('browser-sync');

  browserify = require('browserify');

  watchify = require('watchify');

  coffeeify = require('coffeeify');

  bd = require('browserify-data');

  source = require('vinyl-source-stream');

  jade = require('gulp-jade');

  less = require('gulp-less');

  clean = require('gulp-clean');

  zopfli = require('gulp-zopfli');

  rename = require('gulp-rename');

  runSequence = require('run-sequence');

  data = yaml.safeLoad(fs.readFileSync('data.yaml', 'utf8'));

  gulp.task("browser-sync", function() {
    browserSync.init(["public/*.css", "public/*.js", "public/*.html"], {
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
    gulp.src("templates/*.jade").pipe(jade({
      locals: data
    })).pipe(gulp.dest("./public/"));
  });

  gulp.task('copy', function() {
    return gulp.src('./images/**').pipe(gulp.dest('./public/images/'));
  });

  gulp.task('styles', function() {
    return gulp.src(["styles/app.less", 'styles/print.less', 'styles/iefix.less']).pipe(less({
      paths: [path.join(__dirname, "less", "includes")]
    })).pipe(gulp.dest("./public"));
  });

  gulp.task('compile', function() {
    var bundle, opts, w;
    opts = watchify.args;
    opts.extensions = ['.coffee', '.json'];
    w = watchify(browserify('./app/index.coffee', opts));
    w.transform(coffeeify);
    w.transform(bd);
    bundle = function() {
      return w.bundle().pipe(source('app.js')).pipe(gulp.dest('./public/'));
    };
    w.on('update', bundle);
    bundle();
  });

  gulp.task("default", ['compile', 'styles', 'templates', 'browser-sync', 'copy'], function() {
    gulp.watch("templates/*.jade", ["templates"]);
    gulp.watch("styles/*.less", ["styles"]);
    gulp.watch('images/**', ['copy']);
  });

  gulp.task('set_sha', function(cb) {
    var r_ops;
    r_ops = {
      uri: 'https://api.github.com/repos/webmasterkai/sailboat_data/branches/master',
      json: true,
      headers: {
        'user-agent': 'request.js'
      }
    };
    r(r_ops, function(err, response, body) {
      if (err) {
        throw err;
      }
      global.sha = body.commit.sha;
      return cb();
    });
  });

  gulp.task('prod_clean', function() {
    return gulp.src(['./prod/*.js', './prod/*.css', './prod/*.html', './prod/*.html.gz'], {
      read: false
    }).pipe(clean());
  });

  gulp.task('prod_compile', function(cb) {
    var bundler, opts;
    opts = {
      debug: true,
      extensions: ['.coffee', '.json']
    };
    bundler = browserify(opts);
    bundler.transform(coffeeify);
    bundler.transform(bd);
    bundler.add('./app/index.coffee');
    bundler.plugin('minifyify', {
      map: 'script.map.json',
      output: './prod/script.map.json'
    });
    bundler.bundle({
      debug: true
    }).pipe(source(global.sha + '.js')).pipe(gulp.dest('./prod/')).on('end', cb);
  });

  gulp.task('prod_template', function() {
    data.sha = global.sha;
    return gulp.src("templates/*.jade").pipe(jade({
      locals: data
    })).pipe(gulp.dest("./prod/"));
  });

  gulp.task('copy_css', ['styles'], function() {
    gulp.src('./public/app.css').pipe(rename(global.sha + '.css')).pipe(gulp.dest('./prod'));
    gulp.src('./public/print.css', './public/iefix.css').pipe(gulp.dest('./prod'));
    return gulp.src('./images/**').pipe(gulp.dest('./prod/images/'));
  });

  gulp.task('copy_api', function() {
    return gulp.src('./api/**').pipe(gulp.dest('./prod/api/'));
  });

  gulp.task('compress', function() {
    return gulp.src(["./prod/*.js", './prod/*.css', './prod/*.html']).pipe(zopfli()).pipe(gulp.dest("./prod"));
  });

  gulp.task('prod', function(cb) {
    runSequence(['prod_clean', 'set_sha'], ['prod_template', 'copy_css', 'prod_compile'], 'compress', cb);
  });

  gulp.task('boats', ['data'], function() {
    var boats;
    boats = require('./app/models/names.json');
    return boats.map(function(boat) {
      return r('http://localhost:8000/boat/' + boat.id).pipe(source(boat.id + '.json')).pipe(gulp.dest('./api/boat'));
    });
  });

  gulp.task('data', function() {
    r('http://localhost:8000/boat').pipe(source('names.json')).pipe(gulp.dest('./app/models/'));
    return r('http://localhost:8000/phrf').pipe(source('phrf.json')).pipe(gulp.dest('./api/'));
  });

}).call(this);
