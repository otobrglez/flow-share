class App.Models.Step extends App.Models.BaseModel
  paramRoot: 'step'
#  url: -> App.api_url + "/flows/#{@parent.id}/steps"

  defaults:
    name: "New Step"

  initialize: (raw)->
    super(raw)

    if raw? and @get("attachments")?
      @attachments_collection = new App.Collections.Attachments(@get("attachments"))
    else
      @attachments_collection = new App.Collections.Attachments()

  color: ()->
    color = "transparent"
    if (image = @get("image"))? and image.color?
      color = image.color
    color

  color_invert: ()->
    color = "transparent"
    if (image = @get("image"))? and image.color_invert?
      color = image.color_invert

    if color == "transparent"
      color = "#000000"
    color

class App.Collections.Steps extends Backbone.Collection
  model: App.Models.Step
  url: -> App.api_url + "/flows/#{@parent.id}/steps"

  initialize: (models, options)->
    @parent ||= if options? and options.parent? then options.parent else null
    super models, options

class App.Models.Attachment extends Backbone.Model

class App.Collections.Attachments extends Backbone.Collection
  model: App.Models.Attachment
