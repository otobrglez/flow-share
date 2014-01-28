class App.Models.User extends Backbone.Model
  urlRoot: '/users'
  paramRoot: 'user'

  validation:
    name:
      required: true

  toJSON: ->
    id: @id
    full_name: @get('full_name')
    username: @get('username')

  name: ->
    @get('full_name') || @get('username')

  avatar_url: ->
    @get('avatar_url')

  guest: -> false

class App.Models.Guest extends App.Models.User

  guest: -> true
