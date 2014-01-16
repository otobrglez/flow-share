class App.module('Views.Flows').Flow extends Backbone.Marionette.CompositeView # CompositeView # ItemView
  tagName: 'li'
  className: 'flow'
  template: 'flows/flow'

  bindings:
    '#flow_name': {
      observe: 'name',
      events: ['blur']
    },
    '#flow_created_at':   'created_at'
    '#flow_updated_at':   'updated_at'
    '#flow_updated_ago':  'updated_ago'

  events:
    'keypress #flow_name':    'handle_contenteditable'
    'click .flow_destroy':    'flow_destroy'
    'click .flow_share':      'flow_share'
    'click .step_new':        'step_new'
    'click .mode_change':     'mode_change'

  buildItemView: (item, ItemViewType, itemViewOptions)->
    new App.Views.Steps.Step(_.extend({model: item}, itemViewOptions))

  initialize: (options)->
    @collection = new App.Collections.Steps @model.get("steps"), parent: @model
    @listenTo @model, "change", => @model.save()
    @listenTo @collection, "step:created", => @render()
    # super

  serializeData: ->
    Object.merge super, flow_accesses: @model.flow_accesses

  flow_destroy: (e)->
    e.preventDefault()
    @$el.fadeOut "fast", => @model.destroy()

  flow_share: (e)->
    e.preventDefault()

    popup = new App.Views.Flows.Share(model: @model)
    popup.on "popup:close", => @flow_fetch()

    App.Views.Popup.open popup

  flow_fetch: ->
    App.mainRegion.currentView.collection.fetch reset: true

  mode_change: (e)->
    e.preventDefault()
    @display_mode = $(e.currentTarget).data("mode")
    @render()

  handle_contenteditable: (e)->
    e.which != 13

  bind_sorting: (e)->
    unless @$el.find("ul.steps-list").hasClass("ui-sortable")
      @$el.find("ul.steps-list").sortable(
        handle: '.step_move'
        update: (event, ui)->
          ui.item.find(".step_row_order").trigger
            type: "change_index"
            index: ui.item.index()
      ) # .disableSelection()

  step_new: (e)->
    e.preventDefault()
    @collection.create (step = new App.Models.Step()),
      silent: true, wait: false, success: =>
        @collection.trigger "step:created", step

  onRender: ->
    @stickit()
    @bind_sorting()

  appendHtml: (view, item)->
    view.$el.find("ul.steps-list").append(item.el)


