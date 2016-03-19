module.exports =
  paths:
    app: "app"
    views: "app/views/**/*.jade"
    images: [
      "app/assets/images/**/*"
      "node_modules/fancybox/dist/img/*"
    ]
    stylesheets: "app/assets/stylesheets/**/*.css"
    javascripts: "app/assets/javascripts/**/*.coffee"
    mainStylesheet: "app/assets/stylesheets/application.css"
    mainJavascript: "app/assets/javascripts/application.coffee"
  buildpaths:
    root: "build"
    assets: "build/assets"
