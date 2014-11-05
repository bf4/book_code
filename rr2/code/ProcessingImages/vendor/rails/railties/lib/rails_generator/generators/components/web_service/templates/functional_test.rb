#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../test_helper'
require '<%= file_path %>_controller'

class <%= class_name %>Controller; def rescue_action(e) raise e end; end

class <%= class_name %>ControllerApiTest < Test::Unit::TestCase
  def setup
    @controller = <%= class_name %>Controller.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
<% for method_name in args -%>

  def test_<%= method_name %>
    result = invoke :<%= method_name %>
    assert_equal nil, result
  end
<% end -%>
end
