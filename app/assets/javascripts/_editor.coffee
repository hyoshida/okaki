class @Editor
  constructor: ->
    @setSelectors()
    @syncScroller()

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
