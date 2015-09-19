gulp = require "gulp"
del = require "del"
app_config = require "../config/application"

gulp.task "clean:views", (cb) -> del([app_config.buildpaths.root + "/**/*.html"], cb)
gulp.task "clean:stylesheets", (cb) -> del([app_config.buildpaths.assets + "/**/*.css"], cb)
gulp.task "clean:javascripts", (cb) -> del([app_config.buildpaths.assets + "/**/*.js"], cb)
gulp.task "clean:images", (cb) ->
  del(app_config.buildpaths.assets + "/**/*.{png,jpg,gif}", cb)
