/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
addCardClickHandler = function(){ 
  window.currentCardIndex = window.currentCardIndex || 0; 
  $("#addcard").click(function(event){
    event.preventDefault();

    var card = $("<div></div>")
      .attr("id", "card" + (window.currentCardIndex++)) 
      .attr("class", "card")
      .attr("draggable", true);
      
    var editor = $("<div></div>")
      .attr("contenteditable", true)
      .attr("class", "editor");
  
    card.append(editor);
    card.appendTo($("#cards"));
  });
};

var createDragAndDropEvents = function(){
  var cards = $("#cards");
  
  cards.on("dragstart", ".card", function(event){
    event.originalEvent.dataTransfer.setData('text', this.id); 
  });
  
  cards.on("drop",".card", function(event){
    event.preventDefault();
    var id = event.originalEvent.dataTransfer.getData('text');
    var originalCard = $("#" + id); 
    originalCard.insertAfter(this);
    return(false);
  });
  
  cards.on("focus",".editor" , function(event){
    $(this).parent().removeAttr('draggable'); 
  });
  
  cards.on("blur",".editor", function(event){
    $(this).parent().attr('draggable', true);
  });
  
  cards.on("dragover", ".card", function(event){
    event.preventDefault();
    return(false);
  });
  
};


if ('draggable' in document.createElement('div')) {  
  createDragAndDropEvents();
}else{
  Modernizr.load(
    {
      load: "http://code.jquery.com/ui/1.10.3/jquery-ui.js",
      callback: function(result, url, key){ 
        $('#cards').sortable();  
      }
    }  
  );
}

addCardClickHandler();



/**
@method __message
@param text {string} The text you want to display
@param [append=null] {boolean} Whether the message should append to the box or not.
@example
    $("a").on("click", function(event){
      window.__message("You clicked a thing!");
    });
*/
window.__message = function(text, append){
  id = "__messagearea"
  var area = document.getElementById(id);
  if(!area){
    area = document.createElement("textarea");
    area.id = id;
    body = document.getElementsByTagName("body")[0];
    body.insertBefore(area, body.firstChild);
    area.style.height = "50px";
    area.style.width = "100%";
    area.style.overflow = "scroll";
    area.style.position = "relative";
    area.style.border = "1px solid #ddd";
  }
  if(append){
    area.innerHTML = text + "<br>" + area.innerHTML;  
  }else{
    area.innerHTML = text;
  }
};

  
