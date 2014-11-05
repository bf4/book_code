# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//#START_HIGHLIGHT
$ -> 
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()
//#END_HIGHLIGHT
