class App.module('Views.Flows').Show extends Backbone.Marionette.ItemView
  template: 'flows/show'

  render: ->
    super
    flow_view = new App.Views.Flows.Flow(model: @model)
    @$el.find("ul.flows-list").html flow_view.render().el
