#= require_self
#= require ./core_ext
#= require_tree ./controllers
#= require_tree ./templates
#= require_tree ./models
#= require ./views/popup
#= require_tree ./views
#= require ./router

window.App = new Backbone.Marionette.Application

App.api_url = "/api"

App.module 'Models'
App.module 'Collections'
App.module 'Controllers'
App.module 'Routers'

App.addInitializer ->
  @addRegions
    mainRegion: '#live'
    popupRegion: '#popup'
    headerRegion: '#header'
    errorsRegion: '#errors'

  @router = new @Routers.Main
    controller: new @Controllers.Main

  $(document).on 'click', 'a', (e)->
    path = $(this).attr('href')
    if path? and path.startsWith('/') and !$(this).data('reload')?
      e.preventDefault()
      App.router.navigate(path, trigger: true)

  App.Views.Header.init()
  App.Views.Popup.init()
  App.Views.ErrorWatcher.init()


App.on 'initialize:after', ->
  Backbone.history.start(pushState: true) if Backbone.history?

$(document).ready -> App.start()

