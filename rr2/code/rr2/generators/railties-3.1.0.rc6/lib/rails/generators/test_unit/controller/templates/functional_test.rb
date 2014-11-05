#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

<% module_namespacing do -%>
class <%= class_name %>ControllerTest < ActionController::TestCase
<% if actions.empty? -%>
  # test "the truth" do
  #   assert true
  # end
<% else -%>
<% actions.each do |action| -%>
  test "should get <%= action %>" do
    get :<%= action %>
    assert_response :success
  end

<% end -%>
<% end -%>
end
<% end -%>
