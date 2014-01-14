class App.module('Views.Users').Profile extends App.Views.Popup
  className: 'profile'
  template: 'users/profile'

  serializeData: ->
    Object.merge @model.toJSON(),
      avatar_url: @model.avatar_url()
      name: @model.name()
