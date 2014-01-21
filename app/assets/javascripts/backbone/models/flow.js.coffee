class App.Models.Flow extends App.Models.BaseModel
  url: ->
    base = App.api_url + '/flows'
    base = "#{base}/#{@get('id')}" if @get("id")?
    base

  paramRoot: 'flow'

  validation:
    name:
      required: true

  defaults:
    name: "New Flow"

  toJSON: ->
    id: @id
    name: @get('name')
    public: if @public() then 1 else 0

  public: ->
    result = false
    if @get('public')? and @get('public') == true or @get('public') == 1
      result = true
    result

  owned_by: (user)->
    @get('creator').id == user.get('id')

  initialize: (raw)->
    super raw

    if not(raw?) or not(raw.flow_accesses?)
      fa = new App.Models.FlowAccess()
      fa.user = App.current_user
      @flow_accesses = [ fa ]

    @flow_accesses = _.map(raw.flow_accesses, (flow_access)->
      new App.Models.FlowAccess(flow_access)
    ) if raw? and raw.flow_accesses?

    this

class App.Collections.Flows extends Backbone.Collection
  url: -> App.api_url + '/flows'
  model: App.Models.Flow
  paramRoot: 'flows'

