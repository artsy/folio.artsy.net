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

  $('#cta-form').submit (e) ->
    e.preventDefault()

    data = {}
    for datum in $(this).serializeArray()
      { name, value } = datum
      data[name] = value

    $.ajax(
      type: 'POST'
      url: 'https://mandrillapp.com/api/1.0/messages/send.json'
      data:
        key: 'YOUR API KEY HERE'
        message:
          from_email: data.email
          from_name: data?.name
          to: [{
            email: 'damon@artsymail.com'
            type: 'to'
          }]
          auto_html: true
          subject: 'Get Folio'
          text: 'I want Folio.'
    ).done (response) ->
      console.log response
