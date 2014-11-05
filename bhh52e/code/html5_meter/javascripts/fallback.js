/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
 var noMeterSupport = function(){
   return(document.createElement('meter').max === undefined);
 }

 if (noMeterSupport()) {
   var fakeMeter, fill, label, labelText, max, meter, value;   
   meter = $("#pledge_goal");
   value = meter.attr("value");
   max = meter.attr("max");
   labelText = "$" + meter.val();

   fakeMeter = $("<div></div>");
   fakeMeter.addClass("meter");
   label = $("<span>" + labelText + "</span>"); 
   label.addClass("label");

   fill = $("<div></div>"); 
   fill.addClass("fill");
   fill.css("width",(value / max * 100) + "%"); 
   fill.append("<div style='clear:both;'><br></div>");
   fakeMeter.append(fill);
   fakeMeter.append(label);
   meter.replaceWith(fakeMeter); 
 }
 