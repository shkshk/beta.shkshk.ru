app_config = require "./application"

autoprefixer = require "autoprefixer-core"
postcssVars = require "postcss-simple-vars"
postcssImport = require "postcss-import"
postcssNested = require "postcss-nested"
postcssMixins = require "postcss-mixins"
postcssColors = require "postcss-color-function"

module.exports = [
  postcssImport(from: app_config.paths.main_stylesheet),
  postcssMixins,
  postcssNested,
  postcssVars,
  postcssColors(),
  autoprefixer
]
