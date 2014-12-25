gulp = require "gulp"
gutil = require "gulp-util"
streamify = require "gulp-streamify"
del = require "del"
_ = require "lodash"
app_config = require "./config/application"
karma_config = require "./karma.conf.coffee"

production = -> process.env.BUILD_ENV is "production"

jade = require "gulp-jade"
stylus = require "gulp-stylus"
autoprefixer = require "gulp-autoprefixer"
CacheBuster = require("gulp-cachebust")
cachebuster = new CacheBuster()

css_minifier = if production() then require("gulp-csso") else gutil.noop
js_minifier = if production() then -> streamify(require("gulp-uglify")()) else gutil.noop

assets_cachebuster = if production() then -> cachebuster.resources() else gutil.noop
assets_references = if production() then -> cachebuster.references() else gutil.noop

browserify = require "browserify"
karma = require("karma").server
source = require "vinyl-source-stream"

connect = require "gulp-connect"

bundler = browserify(entries: ["./" + app_config.paths.main_javascript], extensions: [".coffee", ".js"])

gulp.task "views", ["clean:views", "stylesheets", "javascripts"], ->
  gulp.src(app_config.paths.views)
    .pipe(jade(pretty: true).on("error", (err) -> gutil.log(err); @emit("end")))
    .pipe(assets_references())
    .pipe(gulp.dest(app_config.buildpaths.root))
    .pipe(connect.reload())
    .on("errror", gutil.log)

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(app_config.paths.main_stylesheet)
    .pipe(stylus("include css": true).on("error", (err) -> gutil.log(err); @emit("end")))
    .pipe(autoprefixer())
    .pipe(css_minifier())
    .pipe(assets_cachebuster())
    .pipe(gulp.dest(app_config.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "javascripts", ["clean:javascripts"], ->
  bundler.bundle()
    .on("error", (err) -> gutil.log(err); @emit("end"))
    .pipe(source("application.js"))
    .pipe(js_minifier())
    .pipe(assets_cachebuster())
    .pipe(gulp.dest(app_config.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "images", ["clean:images"], ->
  gulp.src([app_config.paths.images, "bower_components/fancybox/source/**/*.{jpg,png,gif}"])
    .pipe(gulp.dest(app_config.buildpaths.assets))

gulp.task "serve", ["build"], ->
  connect.server(
    root: app_config.buildpaths.root
    livereload: true
    port: app_config.development_port
  )
  gulp.watch(app_config.paths.views, ["views"])
  gulp.watch(app_config.paths.javascripts, ["javascripts"])
  gulp.watch(app_config.paths.stylesheets, ["stylesheets"])
  gulp.watch(app_config.paths.images, ["images"])

gulp.task "test", (cb) ->
  karma.start(_.assign({}, karma_config, { singleRun: true }), cb)

gulp.task "build", ["views", "images"]
gulp.task "clean:views", (cb) -> del([app_config.buildpaths.root + "**/*.html"], cb)
gulp.task "clean:stylesheets", (cb) -> del([app_config.buildpaths.assets + "**/*.css"], cb)
gulp.task "clean:javascripts", (cb) -> del([app_config.buildpaths.assets + "**/*.js"], cb)
gulp.task "clean:images", (cb) ->
  del(app_config.buildpaths.assets + "**/*.{png,jpg,gif}", cb)
