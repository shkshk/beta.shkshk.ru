module.exports =
  # base path that will be used to resolve all patterns (eg. files, exclude)
  basePath: ''

  # frameworks to use
  # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
  frameworks: ['jasmine-jquery', 'jasmine', 'browserify', 'jquery-2.1.0']

  # list of files / patterns to load in the browser
  files: [
    'test/**/*_spec.coffee'
  ]

  # list of files to exclude
  exclude: [
  ]


  # preprocess matching files before serving them to the browser
  # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
  preprocessors: {
    '**/*.coffee': ['browserify']
  }

  browserify:
    extensions: ['.coffee', '.js']
    paths: ['./app/assets/javascripts']

  # test results reporter to use
  # possible values: 'dots', 'progress'
  # available reporters: https://npmjs.org/browse/keyword/karma-reporter
  reporters: ['progress']

  # web server port
  port: 9876

  # enable / disable colors in the output (reporters and logs)
  colors: true

  # enable / disable watching file and executing tests whenever any file changes
  autoWatch: false

  # start these browsers
  # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
  browsers: ['PhantomJS']

  # Continuous Integration mode
  # if true, Karma captures browsers, runs the tests and exits
  singleRun: false
