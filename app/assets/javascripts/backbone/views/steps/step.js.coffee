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
    super

  handle_contenteditable: (e)->
    e.which != 13

  step_destroy: (e)->
    @$el.fadeOut "slow", => @model.destroy()

  step_add_photo: (e)->

  step_add_files: (e)->
    @$el.find(".step_files").trigger "click"

  change_step_row_order: (e)->
    @model.set step: {row_order_position: e.index}

  bind_file_upload: (e)->
    @$el.find(".step_files").fileupload
      dataType: 'json'
      # add: (e, data)->
      #   data.context = $('<button/>').text('Upload')
      #     .appendTo(document.body)
      done: (e, data)->
        console.log "done"
      #   $.each(data.result.files, function (index, file) {
      #     $('<p/>').text(file.name).appendTo(document.body);
      #   });
      # }


  onRender: ->
    @stickit()
    @bind_file_upload()
