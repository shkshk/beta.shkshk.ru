gulp = require "gulp"
karma = require("karma").server
_ = require "lodash"

karma_config = require "../karma.conf.coffee"

gulp.task "test", (cb) ->
  karma.start(_.assign({}, karma_config, { singleRun: true }), cb)
