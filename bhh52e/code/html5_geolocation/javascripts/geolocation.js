/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
 var getLatitudeAndLongitudeWithFallback = function(){
   if ((typeof google === 'object') &&
       google.loader && google.loader.ClientLocation) { 
         showLocation(google.loader.ClientLocation.latitude, 
                    google.loader.ClientLocation.longitude);
     }else{
       var message = $("<p>Couldn't find your address.</p>"); 
       message.insertAfter("#map");
     }
 };
 
 var getLatitudeAndLongitude = function(){
   navigator.geolocation.getCurrentPosition(function(position) { 
    showLocation(position.coords.latitude, position.coords.longitude);
   });
 };

 
 var showLocation = function(lat, lng){
   var fragment = "&markers=color:red|color:red|label:Y|" + lat + "," + lng;
   var image = $("#map");      
   var source = image.attr("src") + fragment;
   source = source.replace("sensor=false", "sensor=true");
   image.attr("src", source);
 };

 if(Modernizr.geolocation){
   getLatitudeAndLongitude();
 }else{
   Modernizr.load({
     load: "http://www.google.com/jsapi",
     callback: function(){ 
         getLatitudeAndLongitudeWithFallback();
     }
   });
 }

 


