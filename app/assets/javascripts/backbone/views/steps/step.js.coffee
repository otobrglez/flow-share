class App.module('Views.Steps').Step extends Backbone.Marionette.ItemView
  tagName: 'li'
  class: "step"
  template: "steps/step"

  bindings:
    ".step_name": { observe: 'name', events: ['blur'] }
    ".step_comment": "comment"

  events:
    'click a.step_destroy':         'step_destroy'
    'keypress .step_name':          'handle_contenteditable'
    'change_index .step_row_order': 'change_step_row_order'

  initialize: (options)->
    @listenTo @model, "change", => @model.save()
    super

  handle_contenteditable: (e)->
    e.which != 13

  onRender: ->
    @stickit()

  step_destroy: (e)->
    e.preventDefault()
    @$el.fadeOut "slow", => @model.destroy()

  change_step_row_order: (e)->
    @model.set step: {row_order_position: e.index}

