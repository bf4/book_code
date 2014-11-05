/***
 * Excerpted from "Rapid Android Development",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/dsproc for more book information.
***/

document.addEventListener('DOMContentLoaded', function() {
  bindToSketch();  //(1)
}
, false);

function bindToSketch () {
  var sketch = Processing.getInstanceById('MoebiusJSOrientationLocation');
  if ( sketch == undefined )
    return setTimeout(bindToSketch, 200); //(2)

  if (window.DeviceOrientationEvent) {
    window.addEventListener('deviceorientation', function(event) {
      sketch.orientationEvent(event.beta, event.gamma, event.alpha);  //(3)
      console.log(event);
    }
    , false);
  } 
  else if (window.DeviceMotionEvent) {
    window.addEventListener('devicemotion', function(event) {  //(4)
      sketch.orientationEvent(
        event.acceleration.x, event.acceleration.y, event.acceleration.z
      );
    }
    , true);
  } 
  
  else {
    window.addEventListener('DeviceOrientationEvent', function(orientation) { 
      sketch.orientationEvent(orientation.x, orientation.y, orientation.z);
    }
    , true);
  }

  if (navigator.geolocation)
  {
    navigator.geolocation.watchPosition(
    function success(position) {
      sketch.locationEvent(position.coords.latitude, position.coords.longitude);  //(5)
    }
    , 
    function error(e) {
      // Ignore and use defaults already set for coords
      console.log('Unable to get geolocation position data: ' + e);
    }
    );
  }
}  

