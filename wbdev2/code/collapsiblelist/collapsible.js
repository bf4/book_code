/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
(function($) {
  $.fn.toggleExpandCollapse = function(event) {
    event.stopPropagation();
    if (this.find('ul').length > 0) {
      event.preventDefault();

      this.toggleClass('collapsed').toggleClass('expanded');
    }

    return this;
  }

  $.fn.makeCollapsible = function() {
    this.prependToggleAllLinks();
    this.find('li').click(function(event) {
      $(this).toggleExpandCollapse(event);
    });
    this.find('li ul').
      parent(':not(.expanded)').
      addClass('collapsed');

    return this;
  }

  $.fn.prependToggleAllLinks = function() {
    var $container = $('<div>').attr('class', 'expand_or_collapse_all');
    $container.append(
        $('<a>')
          .attr('href', '#')
          .html('Expand all')
          .click(handleExpandAll.bind(this))
      ).append(' | ')
      .append(
        $('<a>')
          .attr('href', '#')
          .html('Collapse all')
          .click(handleCollapseAll.bind(this))
      );
    this.prepend($container);
    return this;
  }

  function handleExpandAll(event) {
    this.find('li.collapsed').toggleExpandCollapse(event);
  }

  function handleCollapseAll(event) {
    this.find('li.expanded').toggleExpandCollapse(event);
  }
})(jQuery);

