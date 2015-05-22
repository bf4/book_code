#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'assert_performance'
require 'performance_benchmark'

class TestAssertPerformance < Minitest::Test

  def test_assert_performance
    actual_performance = performance_benchmark("string operations") do
      result = ""
      700.times do
        result += ("x"*1024)
      end
    end
    assert_performance actual_performance
  end

end
