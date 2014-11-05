#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
require 'test_helper'

class RoutingTest < ActionController::TestCase

  # the following is needed for Rails 2.2.2, but entirely unnecessary for
  # 2.3.2
  tests StoreController
  def setup
    load "config/routes_with_conditions.rb"
  end

  def test_method_specific_routes
    assert_recognizes({"controller" => "store", "action" => "display_checkout_form"},
                       :path => "/store/checkout", :method => :get)
    assert_recognizes({"controller" => "store", "action" => "save_checkout_form"},
                      :path => "/store/checkout", :method => :post)
  end
end

