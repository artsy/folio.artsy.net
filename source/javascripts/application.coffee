scrollTo = ($el, duration = 500) ->
  position = $el.offset().top - $('.header').height()
  $('html, body').animate { scrollTop: position }, duration

$ ->
  $('.section-cta-button').click (e) ->
    e.preventDefault()
    scrollTo $('#cta')
  $('.push-down').click (e) ->
    e.preventDefault()
    scrollTo $('.section-2')
