/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
(function($) {
  $.fn.toggleExpandCollapse = function(event) {
    event.stopPropagation();
    if (this.find('ul').length > 0) {
      event.preventDefault();
      
      this.toggleClass('collapsed').toggleClass('expanded').
        find('> ul').slideToggle('normal');
    }
    
    return this;
  }
})(jQuery);

function prependToggleAllLinks() {
  var container = $('<div>').attr('class', 'expand_or_collapse_all');
  container.append(
      $('<a>').attr('href', '#').
      html('Expand all').click(handleExpandAll)
    ).
    append(' | ').
    append(
      $('<a>').attr('href', '#').
      html('Collapse all').click(handleCollapseAll)
    );
  $('ul.collapsible').prepend(container);
}

function handleExpandAll(event) {
  $('ul.collapsible li.collapsed').toggleExpandCollapse(event);
}

function handleCollapseAll(event) {
  $('ul.collapsible li.expanded').toggleExpandCollapse(event);
}

function initializeCollapsibleList() {
  $('ul.collapsible li').click(function(event) {
    $(this).toggleExpandCollapse(event);
  });
  $('ul.collapsible li:not(.expanded) > ul').hide();
  $('ul.collapsible li ul').
    parent(':not(.expanded)').
    addClass('collapsed');
}

$(document).ready(function() {
  initializeCollapsibleList();
  prependToggleAllLinks();
})
