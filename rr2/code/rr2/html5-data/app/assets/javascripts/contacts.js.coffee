#START:text_summary
text_summary_for = (contact) =>
  contact.dataset['name'] +
    " lives in " +
    contact.dataset['city'] +
    " in " +
    contact.dataset['country']
#END:text_summary
#START:bind
$ ->
  $('.contact').bind 'mouseenter', (event) =>
    contact = event.target
    $('#tip').html text_summary_for(contact)
    $('#tip').show()
    $('.contact').bind 'mouseleave', (event) =>
      $('#tip').hide()
#END:bind
