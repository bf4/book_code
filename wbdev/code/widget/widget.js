/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
var jQuery;
if (window.jQuery === undefined || window.jQuery.fn.jquery !== '1.7') {
    var jquery_script = document.createElement('script');
    jquery_script.setAttribute("src",
        "http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js");
    jquery_script.setAttribute("type","text/javascript");
    jquery_script.onload = loadjQuery; // All browser loading, except IE
    jquery_script.onreadystatechange = function () { // IE loading
        if (this.readyState == 'complete' || this.readyState == 'loaded') {
            loadjQuery();
        }
    };
    // Insert jQuery to the head of the page or to the documentElement
    (document.getElementsByTagName("head")[0] || 
      document.documentElement).appendChild(jquery_script);
} else {
    // The jQuery version on the window is the one we want to use
    jQuery = window.jQuery;
    widget();
}

function loadjQuery() {
    // load jQuery in noConflict mode to avoid issues with other libraries
    jQuery = window.jQuery.noConflict(true);
    widget();
}

function widget() {
  jQuery(document).ready(function($) {
    // Load Data
    var account = 'rails';
    var project = 'rails';
    var branch = 'master';

    $.ajax({
      url: 'http://github.com/api/v2/json/commits/list/'+
        account+
        '/'+project+
        '/'+branch,
      dataType: "jsonp",
      success: function(data){
        $.each(data.commits, function(i,commit){
          var commit_div = document.createElement('div');
          commit_div.setAttribute("class", "commit");
          commit_div.setAttribute("id","commit_"+commit.id);
          $('#widget').append(commit_div);
          $('#commit_'+commit.id).append("<h3>"+
            new Date(commit.committed_date)+
            "</h3><p>"+commit.message+"</p>"+
            "<p>By "+commit.committer.login+"</p>");
        });
      }
    });
    
	
    var css = $("<link>", {
      rel: "stylesheet",
      type: "text/css",
      href: "widget.css"
    });
    css.appendTo('head');
  });
}  
