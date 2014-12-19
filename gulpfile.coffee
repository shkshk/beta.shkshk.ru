gulp = require "gulp"
gutil = require "gulp-util"
del = require "del"
app_config = require "./config/application"

jade = require "gulp-jade"
stylus = require "gulp-stylus"
autoprefixer = require "gulp-autoprefixer"

browserify = require "browserify"
source = require "vinyl-source-stream"

connect = require "gulp-connect"

bundler = browserify(entries: ["./" + app_config.paths.main_javascript], extenstions: [".coffee"])

gulp.task "views", ["clean:views"], ->
  gulp.src(app_config.paths.views)
    .pipe(jade(pretty: true).on("error", (err) -> gutil.log(err); @emit('end')))
    .pipe(gulp.dest(app_config.buildpaths.root))
    .pipe(connect.reload())
    .on("errror", gutil.log)

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(app_config.paths.main_stylesheet)
    .pipe(stylus("include css": true).on("error", (err) -> gutil.log(err); @emit('end')))
    .pipe(autoprefixer())
    .pipe(gulp.dest(app_config.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "javascripts", ["clean:javascripts"], ->
  bundler.bundle()
    .pipe(source("application.js"))
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

gulp.task "build", ["views", "stylesheets", "javascripts", "images"]
gulp.task "clean:views", (cb) -> del([app_config.buildpaths.root + "**/*.html"], cb)
gulp.task "clean:stylesheets", (cb) -> del([app_config.buildpaths.assets + "**/*.css"], cb)
gulp.task "clean:javascripts", (cb) -> del([app_config.buildpaths.assets + "**/*.js"], cb)
gulp.task "clean:images", (cb) ->
  del(app_config.buildpaths.assets + "**/*.{png,jpg,gif}", cb)
