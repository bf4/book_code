$.ajax "/products.json",
  type: "GET"
  dataType: "json"
  success: (data, status, XHR) ->
    template = Handlebars.compile $("#product_template").html()
    html = template {products: data}
    $('body').append html
  
  error: (XHR, status, errorThrown) ->
    template = Handlebars.compile $("#error_template").html()
    html = template {error: "Can't load data: #{errorThrown}"}
    $('body').append html
