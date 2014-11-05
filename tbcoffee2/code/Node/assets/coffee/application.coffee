# Fetch all card, column, and board data in parallel, then parse in sequence
fetchInitialData = $.when(
  new window.CardCollection().fetch(parse: false),
  new window.ColumnCollection().fetch(parse: false)
  new window.BoardCollection().fetch(parse: false),
)

fetchInitialData.then ([cardData], [columnData], [boardData]) =>
  options = {parse: true}
  window.allCards = new window.CardCollection(cardData, options)
  window.allColumns = new window.ColumnCollection(columnData, options)
  window.allBoards = new window.BoardCollection(boardData, options)
  renderBoard()
  return

renderBoard = =>
  # Display the last board as the page
  board = window.allBoards.last()
  $board = $("<div class='board' data-board-id='#{board.get('id')}'></div>")
  $('body').append $board
  boardView = new window.BoardView(
    model: board
    el: $board
  ).render()
