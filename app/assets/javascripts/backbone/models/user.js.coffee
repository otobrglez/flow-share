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

  avatar_url: (size=48)->
    gravatar_id = CryptoJS.MD5(@get('email')).toString(CryptoJS.enc.Base64)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}" # &d=#{CGI.escape(default_url)}"

  name: ->
    @get('full_name') || @get('username')

  guest: -> false

class App.Models.Guest extends App.Models.User

  guest: -> true
