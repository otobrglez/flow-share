class App.Controllers.Main
  constructor: ->
    @flows = new App.Collections.Flows

  showView: (view)->
    App.mainRegion.show view

  index: ->
    view = new App.Views.Flows.Index(collection: @flows)
    @flows.fetch()
    @showView view

