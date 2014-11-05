/***
 * Excerpted from "HTML5 and CSS3 Second Edition",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/bhh52e for more book information.
***/
var canvasGraph = function(){
  var title = $('#graph_data h1').text(); 
  var labels = $("#graph_data>ul>li>p[data-name]").map(function(){  
     return this.getAttribute("data-name");
  });
  var percents = $("#graph_data>ul>li>p[data-percent]").map(function(){ 
     return parseInt(this.getAttribute("data-percent")); 
  });
  var bar = new RGraph.Bar('browsers', percents);
  bar.Set('chart.gutter', 50);
  bar.Set('chart.colors', ['red']);
  bar.Set('chart.title', title);
  bar.Set('chart.labels', labels);
  bar.Draw();
  $('#graph_data').hide();
}
$(document).ready(function(){
  var canvas = document.getElementById('browsers');
  if (canvas.getContext){
    canvasGraph();
  }
});
