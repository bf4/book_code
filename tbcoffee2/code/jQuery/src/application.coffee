Backbone.sync = (method, model, options) ->
  # We only have to handle model syncs (not collection syncs)
  if model instanceof window.Card
    collection = window.allCards
    localStorageKey = 'cards'
  else if model instanceof window.Column
    collection = window.allColumns
    localStorageKey ='columns'
  else if model instanceof window.Board
    collection = window.allBoards
    localStorageKey = 'boards'

  switch method
    # 'get' corresponds to a model.fetch() call
    when 'get'
      model.reset collection.get(model.id), {silent: true}
    # 'create' corresponds to a model.save() call on a new model
    when 'create'
      model.set 'id', collection.length + 1
      collection.add(model)
      localStorage[localStorageKey] = JSON.stringify collection.toJSON()
    # 'update' corresponds to a model.save() call on an old model
    when 'update'
      localStorage[localStorageKey] = JSON.stringify collection.toJSON()

  # Simulate a successful jqXHR
  xhr = options.xhr = jQuery.Deferred().resolve(model.toJSON()).promise()
  options.success(model.toJSON())
  xhr

# Wait for the DOM to be ready
$ ->
  # Fetch all boards and display the last (only) one
  board = window.allBoards.last()
  $board = $("<div class='board' data-board-id='#{board.get('id')}'></div>")
  $('body').append $board
  boardView = new window.BoardView(
    model: board
    el: $board
  ).render()
  return
