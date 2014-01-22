class App.module('Views.Flows').Flow extends Backbone.Marionette.CompositeView # CompositeView # ItemView
  tagName: 'li'
  className: 'flow'
  template: 'flows/flow'

  bindings:
    '#flow_name': { observe: 'name', events: ['blur'] },
    '#flow_created_at':   'created_at'
    '#flow_updated_at':   'updated_at'
    '#flow_updated_ago':  'updated_ago'

  events:
    'click a.r':              'prevent_default'
    'keypress #flow_name':    'handle_contenteditable'
    'click .flow_destroy':    'destroy'
    'click .flow_share':      'share'
    'click .step_new':        'new'

  buildItemView: (item, ItemViewType, itemViewOptions)->
    step = new App.Views.Steps.Step(_.extend({model: item}, itemViewOptions))
    step

  initialize: (options)->
    @collection = new App.Collections.Steps @model.get("steps"), parent: @model

    @listenTo @model, "change", =>
      @model.save()

    @listenTo @collection, "step:created", => @render()
    @listenTo @collection, "changed", => @render()

    # super

  prevent_default: (e)->
    e.preventDefault() if e.preventDefault?

  destroy: (e)->
    if (sure = $(e.currentTarget).data("sure"))?
      if confirm(sure)
        @$el.fadeOut "fast", =>
          @model.destroy()

  share: (e)->
    popup = new App.Views.Flows.Share(model: @model)
    popup.on "popup:close", => @flow_fetch()

    App.Views.Popup.open popup

  new: (e)->
    @collection.create (step = new App.Models.Step()),
      silent: true, wait: false, success: =>
        @collection.trigger "step:created", step

  flow_fetch: ->
    App.mainRegion.currentView.collection.fetch reset: true

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

  serializeData: ->
    Object.merge super, flow_accesses: @model.flow_accesses

  appendHtml: (view, item)->
    view.$el.find("ul.steps-list").append(item.el)

  onRender: ->
    @stickit()
    @bind_sorting()


