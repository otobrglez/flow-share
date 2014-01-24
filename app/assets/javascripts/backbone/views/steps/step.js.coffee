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
    'click a.complete':             'complete'
    'keypress .step_name':          'handle_contenteditable'

  initialize: (options)->
    #FIX: This could be a problem
    # @listenTo @model, "change", => @model.save()
    @listenTo @model, "change", =>
      @model.save {}, success: => @render()

    @listenTo @model, "file:added", => @render()

    @listenTo @model.attachments_collection, "add remove", => @render()

  prevent_default: (e)->
    e.preventDefault() if e.preventDefault?

  move: (e)->
    @model.set step: {row_order_position: e.index}

  complete: (e)->
    @model.set("achiever_id", App.current_user.get("id"))

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
    out = Object.merge super,
      attachments: attachments,
      color: @model.color(),
      color_invert: @model.color_invert(),
      completed: @model.completed(),
      can_edit: @model.can_edit(),
      can_do: @model.can_do()
    out

  # DON'T USE THIS
  # fix_height: ->
  #   heights = @$el.parents(".flow").find(".step").map (i,el)-> $(el).height()
  #   max_height = _.max(heights)
  #   console.log max_height
  #   @$el.parents(".flow").find(".step").each (i,el)->$(el).css("height", max_height)
  #   false
  #onShow: ->
  #  @fix_height()

  onRender: ->
    @stickit()
    @bind_attachment_upload()
    @bind_attachments_upload()
    @trigger "item:after_render", @$el


