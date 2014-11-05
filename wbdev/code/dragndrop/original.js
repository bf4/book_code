/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
$('.popup').live('click', updatePopup);

function updatePopup(event) {
  $.get($(event.target).attr('href'), [], updatePopupContent);
  return false;
}

function updatePopupContent(data) {
  if ($('div.popup_window').length == 0) buildPopup();
  
  var popup_window = $('div.popup_window');
  popup_window.find('.body').html($(data.childNodes[0].children));
  popup_window.fadeIn();
}

// Adds the markup needed for our popup window, but only when popup links exist
function buildPopup() {
  if ($('a.popup').length == 0) return;
  
  var popup_window  = $('<div>').attr('class', 'popup_window draggable').css('display', 'none');
  var close         = $('<div>').attr('class', 'close').html('X').click(function() { $(this).parents('.popup_window').fadeOut() });
  var header        = $('<div>').attr('class', 'header handle').append($('<div class="header_text">Product Description</div>')).append(close).append($('<div class="clear"></div>'));
  var body          = $('<div>').attr('class', 'body');
  popup_window.append(header).append(body).appendTo($('body'));
}

$(document).ready(function() {
  buildPopup();
});

$('.handle').live('mousedown', movePopup);

function movePopup(event) {
  event.preventDefault();
  
  var handle = $(event.target);
  var window = $(handle.parents('.draggable')[0]);
  window.addClass('dragging');
  var offsetX = event.pageX - parseInt(window.css('left'));
  var offsetY = event.pageY - parseInt(window.css('top'));
  
  $(document).mousemove(function(move_event) {
    window.css('left', move_event.pageX - offsetX);
    window.css('top',  move_event.pageY - offsetY);
  })
  
  $(document).mouseup(function(up_event) { unbindMovePopup(up_event); window.removeClass('dragging') });
}

function unbindMovePopup(event) {
  $(document).unbind('mousemove');
}
