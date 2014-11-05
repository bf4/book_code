/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
 function styleExamples(){
    $("div.examples").each(function(){
      createTabs(this);
      activateTabs(this);
      displayTab($(this).children("ul.tabs").children().first());
    });
  }

  function createTabs(container){
    $(container).prepend("<ul class='tabs'></ul>");
    $(container).children("div.example").each(function(){
      var exampleTitle = $(this).attr('class').replace('example','');
      $(container).children("ul.tabs").append(
        "<li class='tab "+exampleTitle+"'>"+exampleTitle+"</li>"
      );
    });
  }

   function displayTab(element){
    tabTitle = $(element)
      .attr('class')
      .replace('tab','')
      .replace('selected','').trim();

    container = $(element).parent().parent();
    container.children("div.example").hide();
    container.children("ul.tabs").children("li").removeClass("selected");

    container.children("div."+tabTitle).slideDown('fast');
    $(element).addClass("selected");
  }

   function activateTabs(element){
    $(element).children("ul.tabs").children("li").click(function(){
      displayTab(this);
    });
  }

$(function(){
  styleExamples();
});
