#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../abstract_unit'
require 'test/unit'
require 'pp' # require 'pp' early to prevent hidden_methods from not picking up the pretty-print methods until too late

# Provide some controller to run the tests on.
module Submodule
  class ContainedEmptyController < ActionController::Base
  end
  class ContainedNonEmptyController < ActionController::Base
    def public_action
    end
    
    hide_action :hidden_action
    def hidden_action
    end
    
    def another_hidden_action
    end
    hide_action :another_hidden_action
  end
  class SubclassedController < ContainedNonEmptyController
    hide_action :public_action # Hiding it here should not affect the superclass.
  end
end
class EmptyController < ActionController::Base
  include ActionController::Caching
end
class NonEmptyController < ActionController::Base
  def public_action
  end
  
  hide_action :hidden_action
  def hidden_action
  end
end

class ControllerClassTests < Test::Unit::TestCase
  def test_controller_path
    assert_equal 'empty', EmptyController.controller_path
    assert_equal 'submodule/contained_empty', Submodule::ContainedEmptyController.controller_path
  end
  def test_controller_name
    assert_equal 'empty', EmptyController.controller_name
    assert_equal 'contained_empty', Submodule::ContainedEmptyController.controller_name
 end
end

class ControllerInstanceTests < Test::Unit::TestCase
  def setup
    @empty = EmptyController.new
    @contained = Submodule::ContainedEmptyController.new
    @empty_controllers = [@empty, @contained, Submodule::SubclassedController.new]
    
    @non_empty_controllers = [NonEmptyController.new,
                              Submodule::ContainedNonEmptyController.new]
  end

  def test_action_methods
    @empty_controllers.each do |c|
      assert_equal Set.new, c.send(:action_methods), "#{c.class.controller_path} should be empty!"
    end
    @non_empty_controllers.each do |c|
      assert_equal Set.new('public_action'), c.send(:action_methods), "#{c.class.controller_path} should not be empty!"
    end
  end
end
