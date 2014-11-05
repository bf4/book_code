/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
(function() {
  $(function() {
    return $.ajax("/products.json", {
      type: "GET",
      dataType: "json",
      success: function(data, status, XHR) {
        var html;
        html = Mustache.to_html($("#product_template").html(), {
          products: data
        });
        return $('body').append(html);
      },
      error: function(XHR, status, errorThrown) {
        return $('body').append("AJAX Error: " + status);
      }
    });
  });
}).call(this);
