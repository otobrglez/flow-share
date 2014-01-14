class App.module('Views').Error extends Backbone.Marionette.ItemView
  template: 'error_watcher/error'
  tagName: 'li'
  className: =>
    out = ["error"]
    out.push @model.get("selector") if @model.get("selector")?
    out.join " "

  events:
    "click a.error_close": "error_close"

  error_close: (e)->
    e.preventDefault()
    $(e.currentTarget).parent().fadeOut "fast", => @model.destroy()

  onRender: ->
    setTimeout =>
      @$el.find("a.error_close").trigger("click")
    , 2000


class App.module('Views').ErrorWatcher extends Backbone.Marionette.CollectionView
  itemView: App.Views.Error
  template: 'error_watcher/index'
  tagName: 'ul'

  @init: ->
    App.errorsRegion.show(new App.Views.ErrorWatcher())

  @show_errors: (model=null, errors=[])->
    if errors?
      Object.keys(errors).each (attr_name)=>
        msg = errors[attr_name]
        _.each msg, (error)->
          error = if attr_name != "base" then "#{attr_name} #{error}" else error
          App.Views.ErrorWatcher.add error, attr_name

  @add: (message, selector="base")->
    App.errorsRegion.currentView.collection.add(new App.Models.Error(
      message: message, selector: selector
    ))

  initialize: ->
    @collection = new App.Collections.Errors()

class App.module('Models').Error extends Backbone.Model

class App.module('Collections').Errors extends Backbone.Collection
  model: App.Models.Error
