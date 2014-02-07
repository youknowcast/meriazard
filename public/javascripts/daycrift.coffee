window.daycrift |= {}
daycrift.view |= {}

view = daycrift.view

view.loadingDialog = (opt) ->
  unless opt
    $overlay = $('<div id="overlay"><div id="message"></div></div>')
    $overlay
      .appendTo(document)
    return
