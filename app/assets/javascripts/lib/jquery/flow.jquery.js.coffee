(($, window) ->

  class Flow

    defaults: {}

    constructor: (el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $(el)

      # console.log @$el

    # Additional plugin methods go here
    # myMethod: (echo) ->
    #   @$el.html(@options.paramA + ': ' + echo)

  # Define the plugin
  $.fn.extend Flow: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('Flow')

      if !data
        $this.data 'Flow', (data = new Flow(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window
