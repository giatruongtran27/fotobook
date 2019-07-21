myPreloadFunc = ->
  $('.element-content-mid').mCustomScrollbar()
  $('#preload').delay(300).fadeOut 'fast'

$(document).ready myPreloadFunc
$(document).on 'page:load', myPreloadFunc # Classic Turbolinks
$(document).on 'turbolinks:load', myPreloadFunc # Turbolinks 5