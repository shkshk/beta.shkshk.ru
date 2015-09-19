window.$ = $ = require "jquery"
Application = require "shkshk/application"

describe "Application", ->
  describe ".run", ->
    beforeEach ->
      @fancyboxSpy = spyOn($.fn, "fancybox")

      Application.run()

    it "initializes fancybox", ->
      expect(@fancyboxSpy).toHaveBeenCalled()
