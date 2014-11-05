#!/usr/bin/ruby
#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require "logger"
require "stringio"
require "pathname"

require 'test/unit/collector/dir'
require 'test/unit/ui/console/testrunner'

def main
  old_verbose = $VERBOSE
  $VERBOSE = true

  tests_dir = Pathname.new(__FILE__).dirname.dirname.join('test')

  # Collect tests from everything named test_*.rb.
  c = Test::Unit::Collector::Dir.new

  if c.respond_to?(:base=)
    # In order to supress warnings from ruby 1.8.6 about accessing
    # undefined member
    c.base = tests_dir
    suite = c.collect
  else
    # Because base is not defined in ruby < 1.8.6
    suite = c.collect(tests_dir)
  end


  result = Test::Unit::UI::Console::TestRunner.run(suite)
  result.passed?
ensure
  $VERBOSE = old_verbose
end

exit(main)
