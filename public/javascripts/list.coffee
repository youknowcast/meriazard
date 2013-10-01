$(->
  $tabs = $('#tabs')
  $grid = $('#grid')
  $searchInput = $('#search_input')
  $iframe = $('#async_load_frame')
  gridRowTmpl = '''
  <tr>
  <td class="column_no">{{ no }}</td>
  <td class="column_filename">{{ filename }}</td>
  <td class="column_size">{{ size }}</td>
  <td class="column_type">{{ content_type }}</td>
  <td class="column_created">{{ created }}</td>
</tr>
'''
  DEFAULT_INTERVAL = 100

  # data を読みこんで，grid を更新します．
  search = () ->
    # fixme 検索条件取得
    _url = '/list/search'
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
          $tbdy.append _.template gridRowTmpl, o
        , DEFAULT_INTERVAL * _i
      )(o, i++)

  onDblClickRow = () ->
    alert 'show detail.'

  # 検索します
  $searchInput
    .on 'change', (e) ->
#      search() unless $searchInput.val().text/ / isnt yes

  $iframe
    .on 'load', () ->
      search()

  $grid
    .on 'dblclick', 'tr', onDblClickRow

  search()
)

