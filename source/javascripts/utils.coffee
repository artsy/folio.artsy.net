window.Utils =
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

  qs: ->
    location.search.slice(1).split '&'
      .reduce (memo, pair) ->
        kv = pair.split '='
        memo[kv[0]] = decodeURIComponent kv[1]
        memo
      , {}
