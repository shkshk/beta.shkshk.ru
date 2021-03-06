gulp = require "gulp"
gutil = require "gulp-util"
plumber = require "gulp-plumber"
streamify = require "gulp-streamify"
sync = require("gulp-sync")(gulp).sync

browserSync = require("browser-sync").create()

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

bundler = browserify(
  entries: ["./" + appConfig.paths.mainJavascript]
  extensions: [".coffee", ".js"]
  paths: ["./app/assets/javascripts"]
)

gulp.task "views", ["clean:views"], ->
  gulp.src(appConfig.paths.views)
    .pipe(plumber())
    .pipe(jade(pretty: true))
    .pipe(assetsReferences())
    .pipe(gulp.dest(appConfig.buildpaths.root))

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(appConfig.paths.mainStylesheet)
    .pipe(plumber())
    .pipe(postcss(postprocessors))
    .pipe(cssMinifier())
    .pipe(assetsCachebuster())
    .pipe(gulp.dest(appConfig.buildpaths.assets))
    .pipe(browserSync.stream(match: "**/*.css"))

gulp.task "javascripts", ["clean:javascripts"], ->
  bundler.bundle()
    .on("error", (err) -> gutil.log(err.message); @emit("end"))
    .pipe(source("application.js"))
    .pipe(jsMinifier())
    .pipe(assetsCachebuster())
    .pipe(gulp.dest(appConfig.buildpaths.assets))

gulp.task "images", ["clean:images"], ->
  gulp.src(appConfig.paths.images)
    .pipe(gulp.dest(appConfig.buildpaths.assets))

gulp.task "build", sync(["stylesheets", "javascripts", "images", "views"])

gulp.task "watch:javascripts", ["javascripts"], -> browserSync.reload()
gulp.task "watch:views", ["views"], -> browserSync.reload()
gulp.task "watch:images", ["images"], -> browserSync.reload()

gulp.task "serve", ["build"], ->
  browserSync.init(
    ghostMode: false
    notify: false
    server:
      baseDir: appConfig.buildpaths.root
      reloadDelay: 500
  )

  gulp.watch(appConfig.paths.views, ["watch:views"])
  gulp.watch(appConfig.paths.javascripts, ["watch:javascripts"])
  gulp.watch(appConfig.paths.images, ["watch:images"])
  gulp.watch(appConfig.paths.stylesheets, ["stylesheets"])
