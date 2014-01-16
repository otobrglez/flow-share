class App.module('Views.Flows').Index extends Backbone.Marionette.CompositeView
  template: 'flows/index'
  itemViewContainer: 'ul.flows-list'

  events:
    'click a.flow_new': 'new'

  buildItemView: (item, ItemViewType, itemViewOptions)->
    new App.Views.Flows.Flow(_.extend({model: item}, itemViewOptions))

  new: (e)->
    e.preventDefault()
    @collection.create new @collection.model()

  remove_loader: (view)->
    loading = view.$el.find("ul.flows-list li.loading")
    loading.remove()
    # loading.slideUp "slow", (e)->
    #   $(this).remove()

  appendHtml: (view, item)->
    @remove_loader view

    if item.model.isNew()
      view.$el.find("ul.flows-list").prepend(item.el)
    else
      view.$el.find("ul.flows-list").append(item.el)
