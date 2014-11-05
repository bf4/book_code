#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)
require 'stringio'

class TestRakeExtension < Rake::TestCase

  module Redirect
    def error_redirect
      old_err = $stderr
      result = StringIO.new
      $stderr = result
      yield
      result
    ensure
      $stderr = old_err
    end
  end

  class Sample
    extend Redirect

    def duplicate_method
      :original
    end

    OK_ERRS = error_redirect do
      rake_extension("a") do
        def ok_method
        end
      end
    end


    DUP_ERRS = error_redirect do
      rake_extension("duplicate_method") do
        def duplicate_method
          :override
        end
      end
    end
  end

  def test_methods_actually_exist
    sample = Sample.new
    sample.ok_method
    sample.duplicate_method
  end

  def test_no_warning_when_defining_ok_method
    assert_equal "", Sample::OK_ERRS.string
  end

  def test_extension_complains_when_a_method_that_is_present
    assert_match(/warning:/i, Sample::DUP_ERRS.string)
    assert_match(/already exists/i, Sample::DUP_ERRS.string)
    assert_match(/duplicate_method/i, Sample::DUP_ERRS.string)
    assert_equal :original, Sample.new.duplicate_method
  end

end
