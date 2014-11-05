#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift File.dirname(__FILE__) + "/../lib"
$:.unshift File.dirname(__FILE__) + "/../../activesupport/lib"

require 'test/unit'
require 'active_support'
require 'initializer'

class InitializerTest < Test::Unit::TestCase
  class ConfigurationMock < Rails::Configuration
    def initialize(envpath)
      super()
      @envpath = envpath
    end
    
    def environment_path
      @envpath
    end

    protected
      def root_path
        File.dirname(__FILE__)
      end
  end

  def test_load_environment_with_constant
    config = ConfigurationMock.new("#{File.dirname(__FILE__)}/fixtures/environment_with_constant.rb")
    assert_nil $initialize_test_set_from_env
    Rails::Initializer.run(:load_environment, config)
    assert_equal "success", $initialize_test_set_from_env
  ensure
    $initialize_test_set_from_env = nil
  end
end
