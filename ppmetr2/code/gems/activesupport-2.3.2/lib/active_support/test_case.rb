#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
begin
  gem 'mocha', '>= 0.9.3'
  require 'mocha'
rescue LoadError
  # Fake Mocha::ExpectationError so we can rescue it in #run. Bleh.
  Object.const_set :Mocha, Module.new
  Mocha.const_set :ExpectationError, Class.new(StandardError)
end

require 'test/unit/testcase'
require 'active_support/testing/setup_and_teardown'
require 'active_support/testing/assertions'
require 'active_support/testing/deprecation'
require 'active_support/testing/declarative'

module ActiveSupport
  class TestCase < ::Test::Unit::TestCase
    if defined? MiniTest
      Assertion = MiniTest::Assertion
      alias_method :method_name, :name
    else
      # TODO: Figure out how to get the Rails::BacktraceFilter into minitest/unit
      if defined?(Rails) && ENV['BACKTRACE'].nil?
        require 'rails/backtrace_cleaner'
        Test::Unit::Util::BacktraceFilter.module_eval { include Rails::BacktraceFilterForTestUnit }
      end

      Assertion = Test::Unit::AssertionFailedError

      require 'active_support/testing/default'
      include ActiveSupport::Testing::Default
    end

    include ActiveSupport::Testing::SetupAndTeardown
    include ActiveSupport::Testing::Assertions
    include ActiveSupport::Testing::Deprecation
    extend ActiveSupport::Testing::Declarative
  end
end
