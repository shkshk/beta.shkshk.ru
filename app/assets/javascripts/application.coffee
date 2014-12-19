$ = require "jquery"
require "fancybox"

$ ->
  $(".fancybox").fancybox(
    padding: 0
    margin: 15
    arrows: false
    nextClick: true
    openEffect: "none"
    closeEffect: "none"
    nextEffect: "none"
    prevEffect: "none"
  )
