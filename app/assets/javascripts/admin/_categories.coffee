class @Category
  @addJstreeNode: ($node = '#') ->
    jstree = $('#jstree').jstree(true)
    new_node = jstree.create_node($node)
    jstree.open_node($node) unless jstree.is_open($node)
    jstree.rename_node(new_node, '新しいカテゴリ')
    jstree.set_icon(new_node, 'fa fa-bars')

  constructor: (jstreeJson = null) ->
    @jstreeJson = jstreeJson
    @destroiedNodes = []
    @setSelectors()
    @initializeJstree()

  setSelectors: ->
    @$jstree = $('#jstree')
    @$jstreeJsonField= $('#jstree_json')

  canUseJstree: ->
    return false unless @$jstree.length
    return false unless @$jstreeJsonField.length
    true

  getJstree: ->
    @$jstree.jstree(true)

  initializeJstree: ->
    return unless @canUseJstree()

    _this = @

    @$jstree.jstree({
      core: {
        check_callback: true,
        data: @jstreeJson,
        strings : { new_node: '新しいカテゴリ', icon: 'fa fa-bars' }
      },
      contextmenu: {
        items: ($node) ->
          {
            create: {
              label: '新規追加',
              action: -> _this.getJstree().create_node($node)
            }
            edit: {
              label: '編集する',
              action: -> _this.getJstree().edit($node)
            }
            destory: {
              label: '削除する',
              action: ->
                _this.destroiedNodes.push { _destroy: $node.id }
                _this.getJstree().delete_node($node)
            }
          }
      },
      plugins: ['dnd', 'wholerow', 'contextmenu']
    })

    $('form').submit( =>
      json = @getJstree().get_json().concat(@destroiedNodes)
      jsonString = JSON.stringify(json)
      @$jstreeJsonField.val(jsonString)
    )
