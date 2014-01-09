(($, window) ->

  class Flow

    defaults: {}

    constructor: (el, options) ->
      @options = $.extend({}, @defaults, options)
      @$el = $(el)

      # Set width of inputs
      @set_name_width()

      # Scale input as you type
      @$el.find("#flow_name").keydown (event)=> @set_name_width()

      # Removing items
      @$el.on "click", "a.step_remove", (event)=> @remove_step(event)

      # Focus on name field
      @focus_name()

      # Mark end of flow
      @mark_last_step()

      # Apend first blank step
      @append_blank_step() if @is_editable()

      # Fix numbers
      @fix_numbering()

      # When editing you can change sorting
      if @is_editable()
        @$el.find(".steps").sortable(
          stop: (event, ui)=>
            @mark_last_step()
            #TODO: Other things go here.

        ).disableSelection()

    focus_name: ->
      return false unless @is_editable()
      @$el.find("#flow_name").focus().val(@$el.find("#flow_name").val());

    set_name_width: ->
      element = @$el.find("#flow_name")
      text = element.val() || ""
      size = if text.length+3 < 20 then 20 else (text.length+3)
      element.attr("size", size)

    is_editable: ->
      @$el.hasClass "editable"

    build_step: ->
      step = @$el.find(".step:first").clone()
      step.find("input.step_name").val("")
      step.find(".step_comment").val("")
      step.find("input.step_destroy").prop('checked', false)
      step

    fix_numbering: ->
      @$el.find(".step:not(.blank)").each (index, element)->
        $(element).find(".step_name").attr    "name", "flow[steps_attributes][#{index}][name]"
        $(element).find(".step_comment").attr "name", "flow[steps_attributes][#{index}][comment]"
        $(element).find(".step_destroy").attr "name", "flow[steps_attributes][#{index}][_destroy]"
      @mark_last_step()
      @fix_height()

    fix_height: ->
      heights = @$el.find(".step").map (i,el)-> $(el).height()
      return if heights.length == 0

      max_height = heights[parseInt(Object.max(heights),10)]

      @$el.find(".step").each (i,el)->$(el).css("height", max_height)

    append_blank_step: ->
      new_step = @build_step().removeClass("blank").addClass("dummy")
      new_step.on "click", "a.step_add", (e)=>
        e.preventDefault() if e.preventDefault?
        @add_step()

      @$el.find(".steps").append new_step

      @fix_numbering()

    add_step: ->
      dummy = @$el.find(".step.dummy").removeClass "dummy"
      @append_blank_step()

    remove_step: (e)->
      e.preventDefault() if e.preventDefault?

      input = $(e.currentTarget).parents(".step").find(".step_destroy")
      input.prop("checked", true)
      input.parents("form").trigger("submit")

    mark_last_step: ->
      @$el.find(".step").removeClass("last-step")
      @$el.find(".step:not(.dummy):not(.blank):last")
        .addClass("last-step")

      if @$el.find(".step:not(.dummy)").length > 1
        @$el.find(".step:not(.dummy):last input.step_name").focus()

  $.fn.extend Flow: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('Flow')

      if !data
        $this.data 'Flow', (data = new Flow(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window
