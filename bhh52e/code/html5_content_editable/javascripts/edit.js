/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/

var hasContentEditableSupport = function(){
  return(document.getElementById("edit_profile_link").contentEditable != null)
};

if(hasContentEditableSupport()){
  $("#edit_profile_link").hide();
  var status = $("#status");
  $("span[contenteditable]").blur(function(){
    var field = $(this).attr("id");
    var value = $(this).text();  
    
    var resourceURL = $(this).closest("ul").attr("data-url");
    
    $.ajax({
       url: resourceURL, 
       dataType: "json",
       method: "PUT",
       data: field + "=" + value,
       success: function(data){
         status.html("The record was saved.");
       },
       error: function(data){
         status.html("The record failed to save.");
       }
    });  
  });
}
