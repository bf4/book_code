/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
function hasColorSupport(){
  element = document.createElement("input"); 
  element.setAttribute("type", "color");
  var hasColorType = (element.type === "color");
  // handle partial implementation
  if(hasColorType){ 
    var testString = "foo";  
    element.value = testString; 
    hasColorType = (element.value != testString);
  }
  return(hasColorType);
}


var applyColorPicker = function(){
  $('input[type=color]').simpleColor();
};

if (!hasColorSupport()){
  var script = document.createElement('script');
  script.src = "javascripts/jquery.simple-color.js";
 
  if(script.readyState){   // IE support
    script.onreadystatechange = function () {
      if (this.readyState === 'loaded' || this.readyState === 'complete'){
        script.onreadystatechange = null;
        applyColorPicker();
      }
    };
  }else{
    // Other browsers
    script.onload = applyColorPicker;
  }
 
  document.getElementsByTagName("head")[0].appendChild(script);
}
