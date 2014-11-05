#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
require 'test_helper'

class DesignersControllerTest < ActionController::TestCase

  def setup
    setup_designer
  end
  
  test "should render designer status presenter" do
    get :show, id: @designer.id
    assert_response :success
    assert_select 'section.designer-status .active-projects', text: '3'
  end

end
