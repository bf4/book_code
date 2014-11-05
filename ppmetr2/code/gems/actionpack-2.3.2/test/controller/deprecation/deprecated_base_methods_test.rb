#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class DeprecatedBaseMethodsTest < ActionController::TestCase
  class Target < ActionController::Base
    def home_url(greeting)
      "http://example.com/#{greeting}"
    end

    def raises_name_error
      this_method_doesnt_exist
    end

    def rescue_action(e) raise e end
  end

  tests Target

  def test_log_error_silences_deprecation_warnings
    get :raises_name_error
  rescue => e
    assert_not_deprecated { @controller.send :log_error, e }
  end

  if defined? Test::Unit::Error
    def test_assertion_failed_error_silences_deprecation_warnings
      get :raises_name_error
    rescue => e
      error = Test::Unit::Error.new('testing ur doodz', e)
      assert_not_deprecated { error.message }
    end
  end
end
