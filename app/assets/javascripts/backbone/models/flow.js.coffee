class App.Models.Flow extends App.Models.BaseModel
  url: ->
    base = App.api_url + '/flows'

    if @get("id")?
      new_base = "#{base}/#{@get('id')}"
    else if @get('token')?
      new_base = "#{base}/via_token/#{@get('token')}"
    else
      new_base = base

    new_base

  paramRoot: 'flow'

  validation:
    name: { required: true }

  defaults:
    name: "New Flow"

  toJSON: ->
    id: @id
    name: @get('name')
    public: if @public() then 1 else 0
    open: if @open() then 1 else 0

  public: ->
    result = false
    if @get('public')? and @get('public') == true or @get('public') == 1
      result = true
    result

  open: ->
    result = false
    if @get('open')? and @get('open') == true or @get('open') == 1
      result = true
    result

  public_url: ->
    @get('public_url')

  public_path: ->
    @get('public_path')

  owned_by: (user)->
    @get('creator').id == user.get('id')

  can_edit: ->
    if App.current_user?
      if @isNew()
        return true
      else if App.current_user.get("id") == @get('creator').id
        return true
      else if @get('flow_accesses').map((fa) -> fa.user_id).indexOf(App.current_user.get("id")) != -1
        return true
      else if @open()
        return true
    false


class App.Collections.Flows extends Backbone.Collection
  url: -> App.api_url + '/flows'
  model: App.Models.Flow
  paramRoot: 'flows'

