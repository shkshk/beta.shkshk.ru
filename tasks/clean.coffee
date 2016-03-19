gulp = require "gulp"
del = require "del"
appConfig = require "../config/application"

gulp.task "clean:views", (cb) -> del([appConfig.buildpaths.root + "/**/*.html"], cb)
gulp.task "clean:stylesheets", (cb) -> del([appConfig.buildpaths.assets + "/**/*.css"], cb)
gulp.task "clean:javascripts", (cb) -> del([appConfig.buildpaths.assets + "/**/*.js"], cb)
gulp.task "clean:images", (cb) ->
  del(appConfig.buildpaths.assets + "/**/*.{png,jpg,gif}", cb)
