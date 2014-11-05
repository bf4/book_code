/***
 * Excerpted from "Continuous Testing",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/rcctr for more book information.
***/
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript'); }
});

modit('app', function() {
  function start() {}

  this.exports(start);
});

modit('app', function() {
  function start() {
    $('body').append("<div id='titlebar'/>");
  }

  this.exports(start);
});

modit('app', function() {
  function createToolbar() {
    $('body')
      .append($("<div id='titlebar'/>")
        .click(function() {
          $(this).toggle();
        })
     );
  }

  function start() {
    createToolbar();
    $('#shopping-list').each(function(i, element) {
      app.view.shoppingList(element);
    });
  }

  this.exports(start);
});

$(window.document).ready(app.start);
