class App.Models.BaseModel extends Backbone.Model
  initialize: ()->
    super
    @on "error", @handle_error

  handle_error: (model, xhr, options)->
    if xhr? and (errors = xhr.responseJSON)?
      App.Views.ErrorWatcher.show_errors(
        model, (if errors.errors? then errors.errors else null)
      )
