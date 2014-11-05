#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"

class RenderingTest < ActionDispatch::IntegrationTest
  test ".rb template handler" do
    get "/handlers/rb_handler"
    expected = "This is my first <b>template handler</b>!"
    assert_match expected, response.body
  end
end

class RenderingTest < ActionDispatch::IntegrationTest
  test ".merb template handler" do
    get "/handlers/merb"
    expected = "<p>MERB template handler is <strong>cool and fast</strong>!</p>"
    assert_match expected, response.body.strip
  end

  test ".md template handler" do
    get "/handlers/rdiscount"
    expected = "<p>RDiscount is <em>cool</em> and <strong>fast</strong>!</p>"
    assert_match expected, response.body
  end

  test ".string template handler" do
    get "/handlers/string_handler"
    expected = "Congratulations! You just created another template handler!"
    assert_match expected, response.body
  end
end
