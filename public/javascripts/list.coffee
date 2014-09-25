$(->
  $tabs = $('#tabs')
  $grid = $('#grid')
  $searchInput = $('#search_input')
  $iframe = $('#async_load_frame')
  $searchForm = $('#search_panel')
  gridRowTmpl = '''
  <tr data-doc_id="{{ doc_id }}">
  <td class="column_no">{{ no }}</td>
  <td class="column_filename">{{ filename }}</td>
  <td class="column_size">{{ size }}</td>
  <td class="column_type">{{ content_type }}</td>
  <td class="column_created">{{ created }}</td>
</tr>
'''
  DEFAULT_INTERVAL = 10

  # data を読みこんで，grid を更新します．
  search = (query) ->
    _url = '/list/search'
    if query
      _url += "/#{ query }"
    _query = []
    _url += concreteQuery(_query) if _query.length > 0

    $.getJSON _url, {}, (json) ->
      rewriteRows(json)

  # 検索条件を取得します
#  concreteQuery = () ->

  clearGrid = () ->
    $grid
      .find('tbody>tr')
      .off()
      .remove()

  # row を読み込んでレンダリングします
  rewriteRows = (json) ->
    clearGrid()
    i = 0
    _.each json, (o) ->
      $tbdy = $grid.find('tbody')
      ((_o, _i) ->
        setTimeout () ->
          $tbdy.append _.template gridRowTmpl, _o
        , DEFAULT_INTERVAL * _i
      )(o, i++)

  onDblClickRow = (e) ->
    # file API をチェック
    # unless window.File
    #   alert "cannot use file download.."
    #   return
    dblClicked = $(e.currentTarget).data('doc_id')

    # create hidden iframe, and submit to this.
    _iframe = document.createElement("iframe")
    _iframe.name = "hidden_frame"
    _iframe.style.display = "none"
    document.body.appendChild(_iframe)

    # create form to submit.
    _form = document.createElement('form')
    _form.name = "hidden_form"
    _form.action = "/download/#{ dblClicked }"
    _form.target = _iframe.name
    _form.style.display = "none";
    document.body.appendChild(_form)

    # set cookie to remove loading dialog when response is back from sv.
    $.cookie("loading", '1')
    _form.submit()

    # and delete form.
    document.body.removeChild(_form)

    daycrift.view.loadingDialog()
    _interval = setInterval () ->
      _cookie = $.cookie('loading')
      if _cookie == '1'
        # set flag off.
        $.cookie('loading', '0')
        daycrift.view.loadingDialog('remove')
        clearInterval _interval
    , 50

  $searchForm
    .on 'submit', (e) ->
      false
      # cancel onsubmit.

  # 検索します
  $searchInput
    .on 'change', (e) ->
      _input = $(e.target)
      search( _input.val() )


  $iframe
    .on 'load', () ->
      console.log "start reload."
      search()

  $grid
    .on 'dblclick', 'tr', onDblClickRow

  search()
)

