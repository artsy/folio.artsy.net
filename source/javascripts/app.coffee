window.App = class App
  constructor: -> #

  initialize: ->
    @bind()
    @success()

  success: ->
    return unless Utils.qs().success
    modal = new Modal 'Thanks!<br>Your application has been submitted.'
    modal.open()

  scrollTo: ($el, duration = 500) ->
    position = ($el.position().top - @$header.outerHeight()) + 1
    @$htmlBody.animate { scrollTop: position }, duration

  bind: ->
    @$window = $(window)
    @$htmlBody = $('html, body')
    @$header = $('.header')

    $('.js-learn-more-hero').click (e) =>
      e.preventDefault()
      mixpanel.track 'folio.artsy.net - Clicked "Learn More" in hero'
      @scrollTo $('.section-2')

    mixpanel.track_links '.js-artsy-for-galleries', 'folio.artsy.net - Clicked "Artsy For Galleries"'
    mixpanel.track_links '.js-download-folio', 'folio.artsy.net - Clicked "Download Folio"'
    mixpanel.track_links '.js-learn-more-footer', 'folio.artsy.net - Clicked "Learn More" in footer'

    return if Utils.isTouch()

    $('.js-scroll-to-top').click (e) =>
      e.preventDefault()
      @scrollTo @$htmlBody

    $('.js-scroll-to-fold').click (e) =>
      e.preventDefault()
      @scrollTo $('.section-2')

    element = new Element $el: $('.section-2'), $header: @$header
    @$window.on 'resize', Utils.throttle(-> element.position())
    @$window.on 'scroll', Utils.throttle(=> element.detect @$window.scrollTop())
    element.$el.on 'below', => @$header.addClass 'is-active'
    element.$el.on 'above', => @$header.removeClass 'is-active'
