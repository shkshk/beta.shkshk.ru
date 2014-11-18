module.exports =
  paths:
    app: "app"
    views: "app/views/**/*.jade"
    images: "app/assets/images/**/*"
    stylesheets: "app/assets/stylesheets/**/*.styl"
    main_stylesheet: "app/assets/stylesheets/application.styl"
  buildpaths:
    root: "build"
    stylesheets: "build/assets"
    images: "build/assets"
  development_port: 4000
