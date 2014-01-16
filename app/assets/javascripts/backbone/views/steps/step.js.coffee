class App.module('Views.Steps').Step extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: "step"
  template: "steps/step"

  bindings:
    ".step_name": { observe: 'name', events: ['blur'] }
    ".step_comment": "comment"

  events:
    'click a.r':                    'prevent_default'
    'click a.step_destroy':         'step_destroy'
    'click a.step_add_photo':       'step_add_photo'
    'click a.step_add_files':       'step_add_files'
    'keypress .step_name':          'handle_contenteditable'
    'change_index .step_row_order': 'change_step_row_order'

  prevent_default: (e)->
    e.preventDefault() if e.preventDefault?

  initialize: (options)->
    @listenTo @model, "change", => @model.save()
    @listenTo @model, "file:added", => @render()
    @listenTo @model.attachments_collection, "add", => @render()

  handle_contenteditable: (e)->
    e.which != 13

  step_destroy: (e)->
    @$el.fadeOut "slow", => @model.destroy()

  step_add_photo: (e)->

  step_add_files: (e)->
    @$el.find(".step_files").trigger "click"

  change_step_row_order: (e)->
    @model.set step: {row_order_position: e.index}

  upload_url: ->
    App.api_url + "/steps/#{@model.id}/attachments"

  bind_file_upload: (e)->
    @$el.find(".step_files").fileupload
      url: @upload_url()
      done: (e, data)=>
        @model.attachments_collection.add new App.Models.Attachment(data.result)
      fail: (e, data)->
        errors = data.jqXHR.responseJSON
        App.Views.ErrorWatcher.show_errors(
          @model, (if errors.errors? then errors.errors else null)
        )

  serializeData: ->
    attachments = _.map @model.attachments_collection.models, (model)-> model.attributes
    Object.merge super,
      attachments: attachments

  onRender: ->
    @stickit()
    @bind_file_upload()
