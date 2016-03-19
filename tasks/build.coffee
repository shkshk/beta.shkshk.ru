gulp = require "gulp"
gutil = require "gulp-util"
plumber = require "gulp-plumber"
streamify = require "gulp-streamify"

appConfig = require "../config/application"
postprocessors = require "../config/postcss"

production = -> process.env.NODE_ENV is "production"

jade = require "gulp-jade"
postcss = require "gulp-postcss"
CacheBuster = require "gulp-cachebust"
cachebuster = new CacheBuster()

cssMinifier = if production() then require("gulp-csso") else gutil.noop
jsMinifier = if production() then -> streamify(require("gulp-uglify")()) else gutil.noop

assetsCachebuster = if production() then -> cachebuster.resources() else gutil.noop
assetsReferences = if production() then -> cachebuster.references() else gutil.noop

browserify = require "browserify"
source = require "vinyl-source-stream"
connect = require "gulp-connect"

bundler = browserify(
  entries: ["./" + appConfig.paths.mainJavascript]
  extensions: [".coffee", ".js"]
  paths: ["./app/assets/javascripts"]
)

gulp.task "views", ["clean:views", "stylesheets", "javascripts"], ->
  gulp.src(appConfig.paths.views)
    .pipe(plumber())
    .pipe(jade(pretty: true))
    .pipe(assetsReferences())
    .pipe(gulp.dest(appConfig.buildpaths.root))
    .pipe(connect.reload())

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(appConfig.paths.mainStylesheet)
    .pipe(plumber())
    .pipe(postcss(postprocessors))
    .pipe(cssMinifier())
    .pipe(assetsCachebuster())
    .pipe(gulp.dest(appConfig.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "javascripts", ["clean:javascripts"], ->
  bundler.bundle()
    .on("error", (err) -> gutil.log(err.message); @emit("end"))
    .pipe(source("application.js"))
    .pipe(jsMinifier())
    .pipe(assetsCachebuster())
    .pipe(gulp.dest(appConfig.buildpaths.assets))
    .pipe(connect.reload())

gulp.task "images", ["clean:images"], ->
  gulp.src(appConfig.paths.images)
    .pipe(gulp.dest(appConfig.buildpaths.assets))

gulp.task "build", ["views", "images"]

gulp.task "serve", ["build"], ->
  connect.server(
    root: appConfig.buildpaths.root
    livereload: true
    port: appConfig.developmentPort
  )
  gulp.watch(appConfig.paths.views, ["views"])
  gulp.watch(appConfig.paths.javascripts, ["javascripts"])
  gulp.watch(appConfig.paths.stylesheets, ["stylesheets"])
  gulp.watch(appConfig.paths.images, ["images"])

