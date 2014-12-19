module.exports =
  paths:
    app: "app"
    views: "app/views/**/*.jade"
    images: "app/assets/images/**/*"
    stylesheets: "app/assets/stylesheets/**/*.styl"
    main_stylesheet: "app/assets/stylesheets/application.styl"
    main_javascript: "app/assets/javascripts/application.coffee"
  buildpaths:
    root: "build"
    assets: "build/assets"
  development_port: 4000
