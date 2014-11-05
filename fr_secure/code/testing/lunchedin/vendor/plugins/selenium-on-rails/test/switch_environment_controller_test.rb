#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/test_helper'
require 'mocha'
require 'controllers/switch_environment_controller'

class SwitchEnvironmentControllerTest < Test::Unit::TestCase

  def setup
    @config = mock()
    setup_controller_test(SwitchEnvironmentController)
  end
  
  def test_index
    SeleniumOnRailsConfig.expects(:get).with(:environments).returns("hello dolly")
    get :index
    assert @response.body.include?('hello dolly')
  end
end