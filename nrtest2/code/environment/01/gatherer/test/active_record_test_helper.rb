#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "minitest/autorun"
require "mocha/mini_test"
require 'active_record'
require 'active_support/test_case'
require 'minitest/reporters'

reporter_options = { color: true }
Minitest::Reporters.use!(
  [Minitest::Reporters::DefaultReporter.new(reporter_options)])

connection_info = YAML.load_file("config/database.yml")["test"]
ActiveRecord::Base.establish_connection(connection_info)

module ActiveSupport
  class TestCase
    teardown do
      ActiveRecord::Base.subclasses.each(&:delete_all)
    end
  end
end
