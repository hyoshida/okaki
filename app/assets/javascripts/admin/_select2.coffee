# Based on http://gistflow.com/posts/428-autocomplete-with-rails-and-select2
class @Select2
  constructor: ->
    $('.select2').each(@initializeSelect2)

  initializeSelect2: ->
    $select = $(this)
    options = { theme: 'bootstrap' }
    if $select.hasClass('ajax')
      term_column = $select.data('term') || ['name_cont']
      options.ajax = {
        url: $select.data('source')
        dataType: 'json'
        cache: true
        data: (params) -> { q: { "#{term_column}" : params.term }, page: params.page }
        processResults: (data, page) -> { results: data }
      }
    $select.select2(options)
