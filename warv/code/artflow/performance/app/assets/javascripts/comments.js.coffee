$(document).ready ->

  $('#comment_expander').click (e) ->
    comments = $('#comments li')
    if $(this).text() == 'Expand'
      comments.show()
      $(this).text('Collapse')
    else
      comments.slice(3).hide()
      $(this).text('Expand')
    e.preventDefault()
