scrollTo = ($el, duration = 500) ->
  position = $el.offset().top - $('.header').height()
  $('html, body').animate { scrollTop: position }, duration

isSuccessful = ->
  location.search.substring(1).indexOf('success') is 0

$ ->
  $('.section-cta-button').click (e) ->
    e.preventDefault()
    scrollTo $('#cta')
  $('.push-down').click (e) ->
    e.preventDefault()
    scrollTo $('.section-2')

  if isSuccessful()
    $('#modal').show().html $ """
      <div class='modal-message'>
        <span>Thank you. An Artsy representative will reach out to you.</span>
      </div>
    """
