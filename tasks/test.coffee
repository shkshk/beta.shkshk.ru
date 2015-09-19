gulp = require "gulp"
Server = require("karma").Server
_ = require "lodash"

karma_config = require "../karma.conf.coffee"

gulp.task "test", (cb) ->
  server = new Server(_.assign({}, karma_config, { singleRun: true }), cb)
  server.start()
