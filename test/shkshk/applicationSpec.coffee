$ = require "jquery"
Application = require "../../app/assets/javascripts/shkshk/application.coffee"
Application.$ = $

describe "Application", ->
  describe ".run", ->
    beforeEach ->
      @fancyboxSpy = spyOn($.fn, "fancybox")
      @placeholderSpy = spyOn($.fn, "placeholder")

      Application.run()

    it "initializes fancybox", ->
      expect(@fancyboxSpy).toHaveBeenCalled()

    it "initializes jquery-placeholder", ->
      expect(@placeholderSpy).toHaveBeenCalled()
