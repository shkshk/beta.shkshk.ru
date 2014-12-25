$ = require "jquery"
Application = require "shkshk/application"
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
