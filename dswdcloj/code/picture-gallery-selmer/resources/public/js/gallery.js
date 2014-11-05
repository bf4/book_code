/***
 * Excerpted from "Web Development with Clojure",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dswdcloj for more book information.
***/
$(document).ready(function(){
    $("#delete").click(deleteImages);    
});
function deleteImages() {
    var selectedInputs = $("input:checked"); 
    var selectedIds = []; 
    selectedInputs
    .each(function() {
                selectedIds.push($(this).attr('id'));
            });
    if (selectedIds.length < 1) alert("no images selected");
    else 
        $.post(context + "/delete", 
              {names: selectedIds}, 
              function(response) {                
                  var errors = $('<ul>');
                 $.each(response, function() {                                
                 if("ok" === this.status) {                     
                    var element = document.getElementById(this.name);
                     $(element).parent().parent().remove();
                }                     
                else
                    errors
                    .append($('<li>',
                            {html: "failed to remove " + 
                                   this.name + 
                                   ": " + 
                                   this.status}));                 
                });
                if (errors.length > 0) 
                    $('#error').empty().append(errors);
             }, 
            "json");
}
