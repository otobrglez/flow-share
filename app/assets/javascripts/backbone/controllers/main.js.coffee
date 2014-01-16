class App.Controllers.Main

  #TODO: For "real-time" please use @keep_alive()
  #TODO: @keep_alive() works only for flows but not for steps

  constructor: ->
    @flows = new App.Collections.Flows()
    # @keep_live()

  showView: (view)->
    App.mainRegion.show view

  keep_live: =>
    @flows.fetch().done =>
      @is_alive = setTimeout App.router.options.controller.keep_live, 2000

  index: ->
    @flows.fetch()

    @showView new App.Views.Flows.Index(collection: @flows)

