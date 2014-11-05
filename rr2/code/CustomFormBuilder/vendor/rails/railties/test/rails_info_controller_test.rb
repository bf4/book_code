#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift File.dirname(__FILE__) + "/../lib"
$:.unshift File.dirname(__FILE__) + "/../builtin/rails_info"
$:.unshift File.dirname(__FILE__) + "/../../actionpack/lib"
$:.unshift File.dirname(__FILE__) + "/../../activesupport/lib"

require 'test/unit'
require 'action_controller'
require 'action_controller/test_process'

require_dependency 'rails/info_controller'
class Rails::InfoController < ActionController::Base
  @local_request = false
  class << self
    cattr_accessor :local_request
  end
  
  # Re-raise errors caught by the controller.
  def rescue_action(e) raise e end;
  
protected
  def local_request?
    self.class.local_request
  end
end

ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

class Rails::InfoControllerTest < Test::Unit::TestCase
  def setup
    @controller = Rails::InfoController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_rails_info_properties_table_rendered_for_local_request
    Rails::InfoController.local_request = true
    get :properties
    assert_tag :tag => 'table'
    assert_response :success
  end
  
  def test_rails_info_properties_error_rendered_for_non_local_request
    Rails::InfoController.local_request = false
    get :properties
    assert_tag :tag => 'p'
    assert_response 500
  end
end
