#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../helper', __FILE__)
require 'rake/clean'

class TestRakeClean < Rake::TestCase
  include Rake
  def test_clean
    load 'rake/clean.rb', true

    assert Task['clean'], "Should define clean"
    assert Task['clobber'], "Should define clobber"
    assert Task['clobber'].prerequisites.include?("clean"),
      "Clobber should require clean"
  end
end
