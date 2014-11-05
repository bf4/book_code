#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'active_support/testing/performance'

module ActionDispatch
  # An integration test that runs a code profiler on your test methods.
  # Profiling output for combinations of each test method, measurement, and
  # output format are written to your tmp/performance directory.
  class PerformanceTest < ActionDispatch::IntegrationTest
    include ActiveSupport::Testing::Performance
  end
end
