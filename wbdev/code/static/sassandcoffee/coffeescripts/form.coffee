$ ->
  $("form").submit (event) ->
    event.preventDefault()
    element = $("<p>You've been added to the list!</p>")
    element.insertAfter($(this))
    $(this).hide()
    