$(->
  $grid = $('#grid')
  gridRowTmpl = '''
  <tr>
  <td class="column_no">{{ no }}</td>
  <td class="column_filename">{{ filename }}</td>
  <td class="column_size">{{ size }}</td>
  <td class="column_created">{{ created }}</td>
</tr>
'''

  # data を読みこんで，grid を更新します．
  search = () ->
    # fixme 検索条件取得
    _url = '/list/search'
    _query = []
    _url += concreteQuery(_query) if _query.length > 0

    $.getJSON _url, {}, (json) ->
      rewriteRows(json)

  # row を読み込んでレンダリングします
  rewriteRows = (json) ->
    _.each json, (o) ->
      $tbdy = $grid.find('tbody')
      ((_o) ->
        setTimeout () ->
          $tbdy.append _.template gridRowTmpl, o
        , 1000
      )(o)

  onDblClickRow = () ->
    console.log 'huga'

  $grid
    .on 'dblclick', 'tr', onDblClickRow

  search()
)

