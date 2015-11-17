window.Element = class Element
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
