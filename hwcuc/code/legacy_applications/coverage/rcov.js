/***
 * Excerpted from "The Cucumber Book",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
***/
function toggleCode( id ) {
  if ( document.getElementById ) {
    elem = document.getElementById( id );
  } else if ( document.all ) {
    elem = eval( "document.all." + id );
  } else {
    return false;
  }
  
  elemStyle = elem.style;

  if ( elemStyle.display != "block" ) {
    elemStyle.display = "block";
  } else {
    elemStyle.display = "none";
  }

  return true;
}

function restripe() {
  i = 0;
  $('table#report_table tbody tr').each(function(){
    if (this.style.display != "none") {
      i += 1;
      classes = this.className.split(" ");
      if ($.inArray("even",classes) != -1) {
        classes.splice($.inArray("even",classes),1);
      } else if ($.inArray("odd",classes) != -1) {
        classes.splice($.inArray("odd",classes),1);
      }
      if (i % 2 === 0) {
        this.className = classes.join(" ") + " odd";
      } else {
        this.className = classes.join(" ") + " even";
      }
    }
  });
}

// Fix IE's lack of support for indexOf (!)
if (!Array.indexOf) { Array.prototype.indexOf = function(obj){ for(var i=0; i<this.length; i++){ if(this[i]==obj){return i;} } return -1; }}