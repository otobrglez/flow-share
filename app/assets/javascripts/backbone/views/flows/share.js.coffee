class App.module('Views.Flows').Share extends App.Views.Popup
  className: 'flow-share'
  template: 'flows/share'
  itemViewContainer: '.users-list'

  buildItemView: (item, ItemViewType, itemViewOptions)->
    item.parent ||= @collection.parent
    new App.Views.Flows.FlowAccess(_.extend({model: item}, itemViewOptions))

  initialize: ->
    @collection = new App.Collections.FlowAccesses(@model.get('flow_accesses'), parent: @model)
    @on "item:added", @item_added
    super

  events:
    'click a.popup_close': 'popup_close'
    'input#query item:added': 'item_added'

  bind_select2: ->
    query = @$el.find("input#query")
    query.select2
      placeholder: "Search for users"
      minimumInputLength: 3
      ajax:
        quietMillis: 200
        url: -> App.api_url + '/users/search'
        data: (term, page)->
          query: term
        results: (data, page)->
          results: data
      formatResult: (user)->
        if user.full_name?
          "<div class='select2-user-result'>#{user.username} - #{user.full_name}</div>"
        else
          "<div class='select2-user-result'><strong>#{user.username}</strong></div>"
      formatSelection: (user)->
        if user.full_name?
          "#{user.username} - #{user.full_name}"
        else
          user.username

    query.on "change", (e)=>@trigger("item:added", e)

  item_added: (e)->
    flow_access = new App.Models.FlowAccess(user_id: e.val)
    flow_access.parent = @collection.parent
    flow_access.save null, success: => @collection.add flow_access

  onRender: ->
    @bind_select2()

class App.module('Views.Flows').FlowAccess extends Backbone.Marionette.ItemView
  template: 'flows/flow_access'
  tagName: 'li'
  className: 'flow_access'

  events:
    "click a.flow_access-destroy": "flow_access_destroy"

  initialize: (options)->
    @listenTo @model, "change", => @model.save()
    super

  flow_access_destroy: (e)->
    e.preventDefault()
    @model.destroy()

  serializeData: ->
    data = super
    Object.merge data, user:
      name: @model.name()
