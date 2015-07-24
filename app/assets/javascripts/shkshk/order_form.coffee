$ = require "jquery"

module.exports = class OrderForm
  constructor: (opts) ->
    @$el = $(opts.el)

    @_initialize()

  _initialize: ->
    @_disableSubmitButton()
    @_runPeriodicChecks()

  _runPeriodicChecks: ->
    setInterval(=>
      if @_contactDataIsNotEmtpy()
        @_enableSubmitButton()
      else
        @_disableSubmitButton()
    , 1000)

  _contactDataIsNotEmtpy: ->
    $.trim(@$el.find("input[name=email]").val()).length

  _disableSubmitButton: ->
    @$el.find("input:submit").attr("disabled", true)

  _enableSubmitButton: ->
    @$el.find("input:submit").attr("disabled", false)
