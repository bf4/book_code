$(document).ready ->

  $('#comment_expander').click (e) ->
    comments = $('#comments li')
    if $(this).text() == 'View All Comments'
      comments.show()
      $(this).text('Collapse Comments')
    else
      comments.slice(3).hide()
      $(this).text('View All Comments')
    e.preventDefault()
