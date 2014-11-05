class window.Column extends Backbone.Model
  defaults:
    name: 'New Column'

  parse: (data) ->
    attrs = _.omit data, 'cardIds'

    # Convert the raw cardIds array into a collection
    attrs.cards = @get('cards') ? new window.CardCollection
    attrs.cards.reset(
      for cardId in data.cardIds or []
        window.allCards.get(cardId)
    )

    attrs

  toJSON: ->
    data = _.omit @attributes, 'cards'

    # Convert the cards collection into a cardIds array
    data.cardIds = @get('cards').pluck 'id'

    data

class window.ColumnCollection extends Backbone.Collection
  model: Column
  url: '/columns'

class window.ColumnView extends Backbone.View

  initialize: (options) ->
    @cardViews = []
    super

  render: ->
    html = JST['templates/column']
      name: @model.get('name')
      cards: @model.get('cards').toJSON()

    @$el.html html

    @cardViews = @model.get('cards').map (card) =>
      cardView = new window.CardView(model: card)
      cardView.setElement @$("[data-card-id=#{card.get('id')}]")
      cardView.render()
      cardView
    @

  events:
    'change [name=column-name]': 'nameChangeHandler'
    'click [name=add-card]': 'addCardClickHandler'

  nameChangeHandler: (e) ->
    @model.save 'name', $(e.currentTarget).val()
    return

  addCardClickHandler: (e) ->
    newCard = new window.Card({}, {parse: true})
    allCards.add(newCard)
    newCard.save().then =>
      @model.get('cards').add(newCard)
      @model.save()
      @render()
      return
    return
