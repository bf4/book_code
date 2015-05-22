/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev2 for more book information.
***/
(function($) {
  var $products_page = $('#products'),
      $products_list = $('#products-list'),
      $product_page  = $('#product');

  $products_page.bind('pagebeforeshow', function() {
    $.getJSON('/products.json', function(products) {
      var $product_list_item;
      $products_list.html('');

      $.each(products, function(i, product) {
        $product_list_item = $('<li>').append(
          $('<a>')
            .attr('href', '#product')
            .text(product.name)
            .data('transition', 'slide')
            .data('product-id', product.id) 
        )
        $products_list.append($product_list_item);
      });

      $products_list.listview('refresh');
    });
  });

  $products_list.on('tap', 'a', function(e) {
    requestProduct($(this).data('product-id'));
  });

  function requestProduct(product_id) {
    $.getJSON('/products/' + product_id + '.json', showProduct)
  }

  function showProduct(product) {
    $('#product-header h1').text(product.name);
    $('#product-content p.description').text(product.description);
    $('#product-content span.price strong').text('$' + product.price);
    }
})(jQuery);
