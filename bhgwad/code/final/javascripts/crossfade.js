/***
 * Excerpted from "Web Design for Developers",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhgwad for more book information.
***/
$(document).ready(function () {

  
  images = [ 
  "images/pasta.jpg", 
  "images/tacosalad.jpg", 
  "images/phadthai.jpg",
  "images/chickenmac.jpg" 
  ] 

  
  
  var image_box = $("#main_image"); 

  image_box.css({'position' : 'relative', 'height': '144px'} ); 
  var image_html = ""; 
  for(var i = 0; i < images.length; i++) { 
    image_html += '<img style="position:absolute;top:0; z-index:' + 
    (images.length - i) + '" src="' + images[i] + '" id="image_' + i + '"/>'; 
  };

  image_box.html(image_html); 

  
  
    var i = 0; 
    var delay_in_miliseconds = 5000;
    
    setInterval(function(){ 
      $("#image_" + i).animate({ opacity: 0}, 3000);
      i++; 
      if(i == images.length) i = 0; 
      $("#image_" + i).animate({ opacity: 1}, 3000);
    },delay_in_miliseconds); 
  

});

