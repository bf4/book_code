#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

# Provide some static controllers.
class BenchmarkedController < ActionController::Base
  def public_action
    render :nothing => true
  end

  def rescue_action(e)
    raise e
  end
end

class BenchmarkTest < ActionController::TestCase
  tests BenchmarkedController

  class MockLogger
    def method_missing(*args)
    end
  end

  def setup
    # benchmark doesn't do anything unless a logger is set
    @controller.logger = MockLogger.new
    @request.host = "test.actioncontroller.i"
  end

  def test_with_http_1_0_request
    @request.host = nil
    assert_nothing_raised { get :public_action }
  end
end
