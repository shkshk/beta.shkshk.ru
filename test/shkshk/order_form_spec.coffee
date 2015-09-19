window.$ = $ = require "jquery"
OrderForm = require "shkshk/order_form"

describe "OrderForm", ->
  beforeEach ->
    setFixtures """
      <form id="foo">
        <input type="text" name="email">
        <input type="submit">
      </form>
    """

    jasmine.clock().uninstall()
    jasmine.clock().install()

    @orderForm = new OrderForm(el: "#foo")

  it "disables submit button", ->
    expect($("input:submit")).toBeDisabled()

  it "runs periodic checks and enables submit button when necessary", ->
    $("input:text").val("foo")
    jasmine.clock().tick(1100)

    expect($("input:submit")).not.toBeDisabled()

    $("input:text").val("")
    jasmine.clock().tick(1100)

    expect($("input:submit")).toBeDisabled()
