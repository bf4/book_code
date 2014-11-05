$(document).ready ->
  if not Modernizr.input.autofocus
    $('#creation_name').trigger 'focus'
