class window.Board extends Backbone.Model
  defaults:
    name: 'New Board'

  parse: (data) ->
    attrs = _.omit data, 'columnIds'

    # Convert the raw columnIds array into a collection
    attrs.columns = @get('columns') ? new window.ColumnCollection
    attrs.columns.reset(
      for columnId in data.columnIds or []
        window.allColumns.get(columnId)
    )

    attrs

  toJSON: ->
    data = _.omit @attributes, 'columns'

    # Convert the columns collection into a columnIds array
    data.columnIds = @get('columns').pluck 'id'

    data

class window.BoardCollection extends Backbone.Collection
  model: Board

boardData = JSON.parse(localStorage.boards)
window.allBoards = new BoardCollection(boardData, {parse: true})

class window.BoardView extends Backbone.View
  initialize: (options) ->
    @listenTo @model.get('columns'), 'add remove', =>
      @model.save()
      @render()
    super

  render: ->
    html = JST['templates/board']
      name: @model.get('name')
      columns: @model.get('columns').toJSON()

    @$el.html html

    @model.get('columns').forEach (column) =>
      columnView = new window.ColumnView(model: column)
      columnView.setElement @$("[data-column-id=#{column.get('id')}]")
      columnView.render()
      columnView
    @

  events:
    'change [name=board-name]': 'nameChangeHandler'
    'click [name=add-column]': 'addColumnClickHandler'

  nameChangeHandler: (e) ->
    @model.save 'name', $(e.currentTarget).val()
    return

  addColumnClickHandler: (e) ->
    newColumn = new window.Column({}, {parse: true})
    newColumn.save()
    @model.get('columns').add(newColumn)
    return
