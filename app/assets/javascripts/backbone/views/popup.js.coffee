class App.module('Views').Popup extends Backbone.Marionette.CompositeView
  tagName: 'div'
  className: 'popup'

  events:
    'click a.popup_close': 'popup_close'

  @init: ->
    App.popup = null

    App.popupRegion.on "show", (view)=>
      view.trigger("popup:show") if view?

    App.popupRegion.on "close", (view)=>
      if App.popup?
        App.popup.trigger("popup:close")
      else if view?
        view.trigger("popup:close")

  @open: (view)->
    App.popupRegion.show(view)
    App.popup = view

  @close: ->
    App.popupRegion.close()

  initialize: ->
    @on "popup:show", @popup_t_show
    @on "popup:close", @popup_t_close

  popup_close: (e)->
    e.preventDefault()
    App.Views.Popup.close()

  popup_t_show: (e)->
    $("#popup").addClass("open")

  popup_t_close: (e)->
    $("#popup").removeClass("open")

