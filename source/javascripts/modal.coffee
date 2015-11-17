window.Modal = class Modal
  constructor: (message) ->
    @message = message

  render: ->
    @$el = $ "
      <div class='modal'>
        <div class='modal-message'>
          <span>#{@message}</span>
        </div>
      </div>
    "
    this

  open: ->
    $('body')
      .prepend @render().$el
