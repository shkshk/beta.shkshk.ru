gulp = require "gulp"
gutil = require "gulp-util"
del = require "del"
app_config = require "./config/application"

jade = require "gulp-jade"
stylus = require "gulp-stylus"
autoprefixer = require "gulp-autoprefixer"

connect = require "gulp-connect"

gulp.task "views", ["clean:views"], ->
  gulp.src(app_config.paths.views)
    .pipe(jade(pretty: true).on("error", (err) -> gutil.log(err); @emit('end')))
    .pipe(gulp.dest(app_config.buildpaths.root))
    .pipe(connect.reload())
    .on("errror", gutil.log)

gulp.task "stylesheets", ["clean:stylesheets"], ->
  gulp.src(app_config.paths.main_stylesheet)
    .pipe(stylus().on("error", (err) -> gutil.log(err); @emit('end')))
    .pipe(autoprefixer())
    .pipe(gulp.dest(app_config.buildpaths.stylesheets))
    .pipe(connect.reload())

gulp.task "serve", ["build"], ->
  connect.server(
    root: app_config.buildpaths.root
    livereload: true
    port: app_config.development_port
  )
  gulp.watch(app_config.paths.views, ["views"])
  gulp.watch(app_config.paths.stylesheets, ["stylesheets"])

gulp.task "build", ["views", "stylesheets"]
gulp.task "clean:views", (cb) -> del([app_config.buildpaths.root + "**/*.html"], cb)
gulp.task "clean:stylesheets", (cb) -> del([app_config.buildpaths.stylesheets], cb)
