appConfig = require "./application"

autoprefixer = require "autoprefixer"
postcssVars = require "postcss-simple-vars"
postcssImport = require "postcss-import"
postcssNested = require "postcss-nested"
postcssMixins = require "postcss-mixins"
postcssColors = require "postcss-color-function"

module.exports = [
  postcssImport(from: appConfig.paths.mainStylesheet),
  postcssMixins,
  postcssNested,
  postcssVars,
  postcssColors(),
  autoprefixer
]
