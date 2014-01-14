class App.Models.Step extends App.Models.BaseModel
  paramRoot: 'step'

  defaults:
    name: "New Step"

class App.Collections.Steps extends Backbone.Collection
  model: App.Models.Step
  url: -> App.api_url + "/flows/#{@parent.id}/steps"

  initialize: (models, options)->
    @parent ||= if options? and options.parent? then options.parent else null
    super models, options
