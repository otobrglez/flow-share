class App.module('Views.Steps').Step extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: "step"
  template: "steps/step"

  bindings:
    ".step_name": { observe: 'name', events: ['blur'] }
    ".step_comment": "comment"

  events:
    'click a.r':                    'prevent_default'
    'change_index .step_row_order': 'move'
    'click a.step_destroy':         'destroy'
    'click a.step_add_photo':       'add_photo'
    'click a.step_add_files':       'add_files'
    'click a.attachment_destroy':   'attachment_destroy'
    'keypress .step_name':          'handle_contenteditable'

  initialize: (options)->
    #FIX: This could be a problem
    @listenTo @model, "change", =>
      @model.save null,
        success: => @render()

    @listenTo @model, "file:added", => @render()

    @listenTo @model.attachments_collection, "add remove", => @render()

  prevent_default: (e)->
    e.preventDefault() if e.preventDefault?

  move: (e)->
    @model.set step: {row_order_position: e.index}

  destroy: (e)->
    @$el.fadeOut "slow", => @model.destroy()

  attachment_destroy: (e)->
    attachment = new App.Models.Attachment $(e.currentTarget).data()
    attachment.url = App.api_url + "/steps/#{@model.id}/attachments/#{attachment.id}"
    attachment.destroy success: =>
      @model.attachments_collection.remove(attachment)

  add_photo: (e)->
    @$el.find(".step_attachment").trigger "click"
  add_files: (e)->
    @$el.find(".step_attachments").trigger "click"

  handle_contenteditable: (e)->
    e.which != 13

  upload_url: ->
    App.api_url + "/steps/#{@model.id}/attachments"

  bind_attachment_upload: (e)->
    @$el.find(".step_attachment").fileupload
      acceptFileTypes: /(\.|\/)(jpe?g|png)$/i
      url: "#{@upload_url()}?single=1"
      done: (e, data)=>
        @model.set("image", data.jqXHR.responseJSON)
      fail: (e, data)->
        errors = data.jqXHR.responseJSON
        App.Views.ErrorWatcher.show_errors(
          @model, (if errors.errors? then errors.errors else null)
        )

  bind_attachments_upload: (e)->
    @$el.find(".step_attachments").fileupload
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
      attachments: attachments,
      color: @model.color(),
      color_invert: @model.color_invert()

  onRender: ->
    @stickit()
    @bind_attachment_upload()
    @bind_attachments_upload()

