# Based on http://reed.github.io/turbolinks-compatibility/facebook.html

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless window.fbEventsBound

bindFacebookEvents = ->
  $(document)
    .on('page:fetch', saveFacebookRoot)
    .on('page:change', restoreFacebookRoot)
    .on('page:load', ->
      FB?.XFBML.parse()
    )
  @fbEventsBound = true

saveFacebookRoot = ->
  if $('#fb-root').length
    @fbRoot = $('#fb-root').detach()

restoreFacebookRoot = ->
  if @fbRoot?
    if $('#fb-root').length
      $('#fb-root').replaceWith @fbRoot
    else
      $('body').append @fbRoot

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  $.getScript("//connect.facebook.net/ja_JP/sdk.js")

initializeFacebookSDK = ->
  FB.init
    # appId  : 'YOUR_APP_ID'
    status : true
    cookie : true
    xfbml  : true
    version: 'v2.6'
