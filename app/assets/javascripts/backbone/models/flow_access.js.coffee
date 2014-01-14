class App.Models.FlowAccess extends App.Models.BaseModel
  paramRoot: 'flow_access'
  url: ->
    base = App.api_url + "/flows/#{@parent.id}/flow_accesses"
    if @id? then "#{base}/#{@id}" else base

  name: ->
    if @get('user')?
      @get('user').full_name || @get('user').username
    else
      "Wait for it..."

  initialize: (raw)->
    super raw
    @user ||= new App.Models.User(raw.user) if raw? and raw.user?
    this

  # can_destroy: (@parent)->
  #   if @parent.owned_by App.current_user
  #     true
  #   else
  #     if @owned_by App.current_user
  #       true
  #     else
  #       false

  # owned_by: (user)->
  #   @get('user').id == user.get('id')


class App.Collections.FlowAccesses extends Backbone.Collection
  model: App.Models.FlowAccess
  url: -> App.api_url + "/flows/#{@parent.id}/flow_accesses"

  initialize: (models, options)->
    @parent ||= if options? and options.parent? then options.parent else null
    super models, options
