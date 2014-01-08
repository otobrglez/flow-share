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

      # Sorting of steps
      @$el.find(".steps .step").sortable()


    focus_name: ->
      return false unless @is_editable()
      @$el.find("#flow_name").focus().val(@$el.find("#flow_name").val());

    set_name_width: ->
      element = @$el.find("#flow_name")
      text = element.val() || ""
      size = if text.length+3 < 10 then 10 else (text.length+3)
      element.attr("size", size)

    is_editable: ->
      @$el.hasClass("editable")

    build_step: ->
      step = @$el.find(".step:first").clone()
      #TODO: Reset values here
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

    append_blank_step: ->
      number_of_nonblanks = @$el.find(".row:last .step:not(.blank)").length

      if number_of_nonblanks >= 4
        @$el.find(".steps").append(
          '<div class="row">
            <div class="step blank">&nbsp;</div><div class="step blank">&nbsp;</div>
            <div class="step blank">&nbsp;</div><div class="step blank">&nbsp;</div>
          </div>')

      step_to_replace = @$el.find(".row:last .step.blank:first")

      new_step = @build_step().removeClass("blank").addClass("dummy")

      new_step.on "click", "a.step_add", (e)=>
        e.preventDefault() if e.preventDefault?
        @add_step()

      step_to_replace.replaceWith new_step

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
      @$el.removeClass("last-step")
      @$el.find(".step:not(.dummy):not(.blank):last").addClass("last-step")

  $.fn.extend Flow: (option, args...) ->
    @each ->
      $this = $(this)
      data = $this.data('Flow')

      if !data
        $this.data 'Flow', (data = new Flow(this, option))
      if typeof option == 'string'
        data[option].apply(data, args)

) window.jQuery, window
