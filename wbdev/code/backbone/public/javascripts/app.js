/***
 * Excerpted from "Web Development Recipes",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/wbdev for more book information.
***/
$(function(){
  window.products = new ProductsCollection();
  $.ajaxSetup({ cache: false });      
  window.router = new ProductsRouter();
  Backbone.history.start();
});
var Product = Backbone.Model.extend({
  
  defaults: {
    name: "",
    description: "",
    price: ""
  },
  url : function() {
    return(this.isNew() ? "/products.json" : "/products/" + this.id + ".json");
  }
});

var ProductsCollection = Backbone.Collection.extend({
  model: Product,
  url: '/products.json'
});

ProductView = Backbone.View.extend({
  template: $("#product_template"), 
  events: {
    "click .delete": "destroy"
   },
  initialize: function(){
    this.model.bind("change", this.render, this);
    this.render();
   },
   destroy: function(){
     var self = this;
     this.model.destroy({
       success: function(){
         self.remove();
       },
       error: function(){
         $("#notice").html("There was a problem deleting the product.");
       }
     });
   },
  render: function(){  
    var html = Mustache.to_html(this.template.html(), this.model.toJSON() );
    $(this.el).html(html);
    return this;
  }
});

ListView = Backbone.View.extend({
  el: $("#list"), 

  initialize: function() {
    this.collection.bind("add", this.renderProduct, this);
    this.render();
  },

  renderProduct: function(product){    
    var productView = new ProductView({model: product});
    this.el.append(productView.render().el);
  },
  
  render: function() {    
    if(this.collection.length > 0) {
       this.collection.each(this.renderProduct, this);
    } else {
      $("#notice").html("There are no products to display.");
    }
  }  
});


ProductsRouter = Backbone.Router.extend({
    routes: {
      "new": "newProduct",
      "": "index"
    },
    newProduct: function() {
      new FormView( {model: new Product()});
    },
    index: function() {
      window.products.fetch({
        success: function(){          
          new ListView({ collection: window.products });
        },
        error: function(){
          $("#notice").html("Could not load the products.");
        }
      });
    }
});

FormView = Backbone.View.extend({
  el: $("#form"), 
  template: $("#product_form_template"),
  events: {
      "click #cancel": "close",
      "submit form": "save",
  },
  initialize: function(){
    this.render();
  },
  close: function(){
    this.el.unbind();
    this.el.empty();
  },
  save: function(e){
    e.preventDefault();
    data = {
      name: $("#product_name").val(),
      description: $("#product_description").val(),
      price: $("#product_price").val()
    };
    var self = this; 
    this.model.save(data, {
      success: function(model, resp) {
        $("#notice").html("Product saved.");
        window.products.add(self.model);
        window.router.navigate("#");
        self.close();
      },
      error: function(model, resp){
        $("#notice").html("Errors prevented the product from being created.");
      }
    });
  },
  
  render: function(){
    var html = Mustache.to_html(this.template.html(), this.model.toJSON() );     
    this.el.html(html);
  }
});



