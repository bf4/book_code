#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'active_support/testing/performance'
require 'active_support/testing/default'

module ActionController
  # An integration test that runs a code profiler on your test methods.
  # Profiling output for combinations of each test method, measurement, and
  # output format are written to your tmp/performance directory.
  #
  # By default, process_time is measured and both flat and graph_html output
  # formats are written, so you'll have two output files per test method.
  class PerformanceTest < ActionController::IntegrationTest
    include ActiveSupport::Testing::Performance
    include ActiveSupport::Testing::Default
  end
end
