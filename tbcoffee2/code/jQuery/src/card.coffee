class window.Card extends Backbone.Model

class window.CardCollection extends Backbone.Collection
  model: Card

cardData = JSON.parse(localStorage.cards)
window.allCards = new CardCollection(cardData, {parse: true})

class window.CardView extends Backbone.View
  render: ->
    html = JST['templates/card']
      description: @model.get('description')
      dueDate: @model.get('due-date')

    @$el.html html
    @

  events:
    'change [name=card-description]': 'descriptionChangeHandler'
    'change [name=due-date]': 'dueDateChangeHandler'

  descriptionChangeHandler: (e) ->
    @model.save 'description', $(e.currentTarget).val()
    return

  dueDateChangeHandler: (e) ->
    @model.save 'due-date', $(e.currentTarget).val()
    return
