#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'
require './config/routes.rb'

class RoutingTest < ActionController::TestCase

  def test_recognizes
    # Check the default index action gets generated
    assert_recognizes({"controller" => "store", "action" => "index"}, "/")
    
    # Check routing to an action
    assert_recognizes({"controller" => "products", "action" => "index"}, 
                      "/products")
    
    # And routing with a parameter
    assert_recognizes({ "controller" => "line_items", 
                        "action" => "create", 
                        "product_id" => "1" },
                        {path: "/line_items", method: :post},
                        {"product_id" => "1"})
  end
  
  def test_generates
    assert_generates("/", controller: "store", action: "index")
    assert_generates("/products", 
                     { controller: "products", action: "index"})
    assert_generates("/line_items", 
                     { controller: "line_items", action: "create", 
                       product_id: "1"},
                     {method: :post}, { product_id: "1"})
  end
  
  def test_routing
    assert_routing("/", controller: "store", action: "index")
    assert_routing("/products", controller: "products", action: "index")
    assert_routing({path: "/line_items", method: :post},
                     { controller: "line_items", action: "create", 
                       product_id: "1"},
                     {}, { product_id: "1"})
  end
    
end

