gulp = require "gulp"
gutil = require "gulp-util"
plumber = require "gulp-plumber"
streamify = require "gulp-streamify"

app_config = require "../config/application"
production = -> process.env.BUILD_ENV is "production"

jade = require "gulp-jade"
stylus = require "gulp-stylus"
autoprefixer = require "gulp-autoprefixer"
CacheBuster = require "gulp-cachebust"
cachebuster = new CacheBuster()

css_minifier = if production() then require("gulp-csso") else gutil.noop
js_minifier = if production() then -> streamify(require("gulp-uglify")()) else gutil.noop

assets_cachebuster = if production() then -> cachebuster.resources() else gutil.noop
assets_references = if production() then -> cachebuster.references() else gutil.noop

browserify = require "browserify"
source = require "vinyl-source-stream"
connect = require "gulp-connect"

bundler = browserify(
  entries: ["./" + app_config.paths.main_javascript]
  extensions: [".coffee", ".js"]
  paths: ["./app/assets/javascripts"]
)

gulp.task "views", ["clean:views", "stylesheets", "javascripts"], ->
  gulp.src(app_config.paths.views)
    .pipe(plumber())
    .pipe(jade(pretty: true))
    .pipe(assets_references())
    .pipe(gulp.dest(app_config.buildpaths.root))
    .pipe(connect.reload())

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(app_config.paths.main_stylesheet)
    .pipe(plumber())
    .pipe(stylus("include css": true))
    .pipe(autoprefixer())
    .pipe(css_minifier())
    .pipe(assets_cachebuster())
    .pipe(gulp.dest(app_config.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "javascripts", ["clean:javascripts"], ->
  bundler.bundle()
    .pipe(source("application.js"))
    .pipe(js_minifier())
    .pipe(assets_cachebuster())
    .pipe(gulp.dest(app_config.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "images", ["clean:images"], ->
  gulp.src([app_config.paths.images, "bower_components/fancybox/source/**/*.{jpg,png,gif}"])
    .pipe(gulp.dest(app_config.buildpaths.assets))

gulp.task "build", ["views", "images"]

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

