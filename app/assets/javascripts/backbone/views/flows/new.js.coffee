class App.module('Views.Flows').New extends Backbone.Marionette.ItemView
  template: 'flows/new'

  events:
    "submit #new-flow": "save"

  bindings:
    '#name': 'name'

  initialize: (options) ->
    @model = new @collection.model()
    @listenTo @model, 'validated', (_, __, attrs)=> @showErrors(attrs)

  onRender: ->
    @stickit()
    @validateit()

  save: (e) ->
    e.preventDefault()

    if @model.isValid(true)
      @model.save null,
        success: =>
          @collection.add @model
          App.router.navigate("/#{@model.id}", trigger: true)
        error: (post, jqXHR) =>
          @showErrors $.parseJSON(jqXHR.responseText).errors
