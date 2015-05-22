/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
$(document).keydown(function(e) {
  if($(document.activeElement)[0] == $(document.body)[0]){
    switch(e.keyCode){
    // In Page Navigation
    case 74: // j
      scrollToNext();
      break;
    case 75: // k
      scrollToPrevious();
      break;
    // Between Page Navigation
    case 39: // right arrow
      loadNextPage();
      break;
    case 37: // left arrow
      loadPreviousPage();
      break;
    // Search
    case 191: // / (and ? with shift)
      if(e.shiftKey){
        $('#search').focus().val('');
        return false;
      }
      break;
    }
  }
});

var current_entry = -1;

function loadNextPage(){
  var page_number = getCurrentPageNumber() + 1;
  var url = window.location.href;
  if (url.indexOf('page=') != -1){
    window.location.href = replacePageNumber(page_number);
  } 
  else {
    var join_char = (url.indexOf('?') > -1) ? '&' : '?';
    window.location.href += join_char + page_number;
  }
}

function loadPreviousPage(){
  page_number = getCurrentPageNumber() - 1;
  if (page_number > 0){
    window.location.href = replacePageNumber(page_number);
  }
}

function getCurrentPageNumber(){
  return parseInt(getQueryString('page') || 1);
}

function getQueryString(name){
  var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
  var r = window.location.search.substr(1).match(reg);
  var val = null
  if (r != null) val = unescape(r[2]);
  return val;
}

function replacePageNumber(page_number){
  return window.location.href.replace(/page=(\d+)/,'page='+page_number);
}

function scrollToNext(){
  if($('.entry').size() > current_entry + 1){
    current_entry++;
    scrollToEntry(current_entry);
  }
}

function scrollToPrevious(){
  if(current_entry > 0){
    current_entry--;
    scrollToEntry(current_entry);
  }
}

function scrollToEntry(entry_index){
  var top = $("#" + $('.entry')[entry_index].id).offset().top;
  $('html,body').animate({ scrollTop: top }, 'slow');
}
