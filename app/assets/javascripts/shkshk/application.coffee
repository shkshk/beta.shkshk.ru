require("fancybox")($)

module.exports = class Application
  @run: ->
    $(".fancybox").fancybox(
      pixelRatio: 2
      padding: 0
      margin: 15
      arrows: false
      nextClick: true
      openEffect: "none"
      closeEffect: "none"
      nextEffect: "none"
      prevEffect: "none"
    )
