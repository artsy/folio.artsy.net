Utils =
  isTouch: ->
    'ontouchstart' of window or 'onmsgesturechange' of window

  throttle: (fn, threshhold, scope) ->
    threshhold or (threshhold = 100)
    last = null
    deferTimer = null
    ->
      context = scope or this
      now = +new Date
      args = arguments
      if last and now < last + threshhold
        clearTimeout deferTimer
        deferTimer = setTimeout ->
          last = now
          fn.apply context, args
        , threshhold
      else
        last = now
        fn.apply context, args

class Element
  constructor: ({ @$el, @$header }) ->
    @position()

  position: ->
    @top = @$el.position().top - @$header.outerHeight()
    @bottom = @top + @$el.outerHeight()

  detect: (top) ->
    if top > @top
      @above = false
      unless @below
        @below = true
        @$el.trigger 'below'
    else
      @below = false
      unless @above
        @above = true
        @$el.trigger 'above'

class App
  constructor: ->
    @cacheSelectors()
    @bindEvents()
    @touch = Utils.isTouch()

  cacheSelectors: ->
    @$window = $(window)
    @$htmlBody = $('html, body')
    @$header = $('.header')

  bindEvents: ->
    $('.js-learn-more-hero').click (e) =>
      e.preventDefault()
      mixpanel.track 'folio.artsy.net - Clicked "Learn More" in hero'
      @scrollTo $('.section-2')

    mixpanel.track_links '.js-artsy-for-galleries', 'folio.artsy.net - Clicked "Artsy For Galleries"'
    mixpanel.track_links '.js-download-folio', 'folio.artsy.net - Clicked "Download Folio"'
    mixpanel.track_links '.js-learn-more-footer', 'folio.artsy.net - Clicked "Learn More" in footer'

    return if @touch

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

  scrollTo: ($el, duration = 500) ->
    position = ($el.position().top - @$header.outerHeight()) + 1
    @$htmlBody.animate { scrollTop: position }, duration

$ -> new App
