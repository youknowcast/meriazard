window.daycrift ||= {}
daycrift.view ||= {}

view = daycrift.view

overlayTmpl = '<div id="overlay"></div><div id="message"></div>'
$overlay = null

view.loadingDialog = (opt) ->
  unless opt
    $('body').append( $(overlayTmpl) )
    return
  if opt == 'remove'
    $( '#overlay, #message' ).remove()
