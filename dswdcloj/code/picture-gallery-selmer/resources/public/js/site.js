/***
 * Excerpted from "Web Development with Clojure",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dswdcloj for more book information.
***/
function colorStr(color) {
    return "rgb("+color[0]+","+color[1]+","+color[2]+")";
}
function setColor(div, colors) {    
    var bgColor = colors[0];
    var textColor = colors[1];    
    div.css("background-color", colorStr(bgColor));
    div.find('a').css("color", colorStr(textColor));
}
$(document).ready(function(){
    $(".thumbnail")
            .each(function() {
             var div = $(this);
             var url = div.find('img').attr('src');
             var thumbColors = new AlbumColors(url);
            var color = "";         
            thumbColors.getColors(function(colors) {
            setColor(div, colors);
        });
    });    
});