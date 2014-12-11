scrollTo = ($el, duration = 500) ->
  position = $el.offset().top - $('.header').height()
  $('html, body').animate { scrollTop: position }, duration

isSuccessful = ->
  location.search.substring(1).indexOf('success') is 0

$ ->
  $('.header-text a').click (e) ->
    mixpanel.track 'folio.artsy.net - Clicked Artsy For Galleries'
  $('.footer a').click (e) ->
    mixpanel.track 'folio.artsy.net - Clicked Footer App Store Link'
  $('.section-cta-button').click (e) ->
    e.preventDefault()
    mixpanel.track 'folio.artsy.net - Clicked Get Folio'
    scrollTo $('#cta')
  $('.push-down').click (e) ->
    e.preventDefault()
    scrollTo $('.section-2')

  if isSuccessful()
    mixpanel.track 'folio.artsy.net - Submitted Form'
    $('#modal').show().html $ """
      <div class='modal-message'>
        <span>Thank you. An Artsy representative will reach out to you.</span>
      </div>
    """
