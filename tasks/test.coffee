gulp = require "gulp"
Server = require("karma").Server
_ = require "lodash"

karmaConfig = require "../karma.conf.coffee"

gulp.task "test", (cb) ->
  server = new Server(_.assign({}, karmaConfig, { singleRun: true }), cb)
  server.start()
