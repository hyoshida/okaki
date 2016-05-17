class @Editor
  constructor: ->
    @setSelectors()
    @syncScroller()

    @editor = @initializePagedown()
    @hookInsertIamgeDialog()

  setSelectors: ->
    @$textarea = $('#editor .editor-body-left textarea')
    @$preview = $('#editor .editor-body-right .wmd-preview')

  # Based http://stackoverflow.com/questions/18952623/synchronized-scrolling-using-jquery/18953340#18953340
  syncScroller: ->
    return if @$textarea.length == 0
    return if @$preview.length == 0
    sync = (_event) =>
      textarea = @$textarea.get(0)
      preview = @$preview.get(0)
      percentage = textarea.scrollTop / (textarea.scrollHeight - textarea.offsetHeight)
      preview.scrollTop = percentage * (preview.scrollHeight - preview.offsetHeight)
    @$textarea.on('scroll', sync)

  # from pagedown_init
  initializePagedown: ->
    attr = $('textarea.wmd-input').first().attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.run()
    editor

  hookInsertIamgeDialog: ->
    @editor.hooks.set('insertImageDialog', (callback) ->
      modal = $('#uploadImageDialog').modal()

      $('#js-upload-field').fileupload(
        dataType: 'json'
        done: (_event, data) ->
          $.each(data.result, (_index, params) ->
            callback(params.url)
            modal.modal('hide')
          )
      )

      true # tell the editor that we'll take care of getting the image url
    )
