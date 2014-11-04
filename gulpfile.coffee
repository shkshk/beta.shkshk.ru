gulp = require "gulp"
gutil = require "gulp-util"
app_config = require "./config/application"

jade = require "gulp-jade"

gulp.task "jade", ->
  gulp.src(app_config.paths.views + "/**/*.jade")
    .pipe(jade(pretty: true))
    .pipe(gulp.dest(app_config.buildpaths.root))
    .on("errror", gutil.log)

