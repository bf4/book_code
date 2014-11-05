$ ->
  $.ajax "/products.json",
    type: "GET"
    dataType: "json"
    success: (data, status, XHR) ->
      html = Mustache.to_html $("#product_template").html(), {products: data}
      $('body').append html
	  
    error: (XHR, status, errorThrown) ->
      $('body').append "AJAX Error: #{status}"