class App.module('Views').Header extends Backbone.Marionette.ItemView
  template: 'header/index'

  events:
    'click a.profile_edit': 'profile_edit'

  @init: ->
    App.headerRegion.show new App.Views.Header()


  initialize: (options)->
    @model = App.current_user

  serializeData: ->
    Object.merge @model.toJSON(),
      avatar_url: @model.avatar_url()
      name: @model.name()

  profile_edit: (e)->
    e.preventDefault()
    App.Views.Popup.open new App.Views.Users.Profile(model: @model)
