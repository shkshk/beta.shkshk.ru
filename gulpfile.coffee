gulp = require "gulp"
gutil = require "gulp-util"
app_config = require "./config/application"

jade = require "gulp-jade"
stylus = require "gulp-stylus"
autoprefixer = require "gulp-autoprefixer"

gulp.task "views", ->
  gulp.src(app_config.paths.views + "/**/*.jade")
    .pipe(jade(pretty: true))
    .pipe(gulp.dest(app_config.buildpaths.root))
    .on("errror", gutil.log)

gulp.task "stylesheets", ->
  gulp.src(app_config.paths.main_stylesheet)
    .pipe(stylus())
    .pipe(autoprefixer())
    .pipe(gulp.dest(app_config.buildpaths.stylesheets))
    .on("error", gutil.log)

