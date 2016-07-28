class @Editor
  constructor: ->
    @setSelectors()

    # cannot use editor
    return if @$textarea.length == 0
    return if @$preview.length == 0

    @syncScroller()

    @editor = @initializePagedown()
    @hookInsertIamgeDialog()
    @restoreForm()
    @disableWMDKeybind()
    @addEventListenerToStoreForm()
    @addEventListenerToClearForm()
    @addEventListenerToDraftButton()
    @addEventListenerToDisableSubmitAfterSubmit()

  setSelectors: ->
    @$textarea = $('#editor .editor-body-left textarea')
    @$preview = $('#editor .editor-body-right .wmd-preview')

  # Based http://stackoverflow.com/questions/18952623/synchronized-scrolling-using-jquery/18953340#18953340
  syncScroller: ->
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

  storeKey: ->
    window.location.pathname

  restoreForm: ->
    storeKey = @storeKey()
    values = store.get(storeKey)
    @$textarea.closest('form').values(values)

  #
  # Disable the WMD keybind.
  # It is registered by following code:
  #   https://github.com/hughevans/pagedown-bootstrap-rails/blob/v2.1.2/vendor/assets/javascripts/markdown.editor.js.erb#L1172-L1235
  #
  disableWMDKeybind: ->
    $wmd_input = $('#wmd-input-body')
    return if $wmd_input.length == 0

    ignore = (event) ->
      return unless (event.ctrlKey || event.metaKey) && !event.altKey && !event.shiftKey
      keyCode = event.charCode || event.keyCode
      keyCodeString = String.fromCharCode(keyCode).toLowerCase()
      return unless $.inArray(keyCodeString, ['b', 'i', 'l', 'q', 'k', 'g', 'o', 'u', 'h', 'r'])
      event.stopPropagation()

    parent = $wmd_input.parent()[0]
    parent.addEventListener('keydown', ignore, true)
    parent.addEventListener('keypress', ignore, true)
    parent.addEventListener('keyup', ignore, true)

  addEventListenerToStoreForm: ->
    storeKey = @storeKey()
    @$textarea.closest('form').keyup(->
      values = $(this).values()

      # Delete sysmtem params
      delete values['utf8']
      delete values['_method']
      delete values['authenticity_token']

      store.set(storeKey, values)
    )

  addEventListenerToClearForm: ->
    func = -> (store.clear())
    @$textarea.closest('form').submit(func)
    $('#js-cancel').click(func)

  addEventListenerToDraftButton: ->
    $('#js-draft').on('click', (_event) ->
      $checkbox = $(this).find('input[type="checkbox"]')
      $checkbox.prop('checked', true)
      $form = $(this).closest('form')
      $form.submit()
    )

  addEventListenerToDisableSubmitAfterSubmit: ->
    @$textarea.closest('form').submit( ->
      $(this).find('.btn-group').find('input[type="submit"], .btn').prop('disabled', true)
    )
