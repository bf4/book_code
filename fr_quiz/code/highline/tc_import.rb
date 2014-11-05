#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

require "test/unit"

require "highline/import"
require "stringio"

class TestImport < Test::Unit::TestCase
  def test_import
    assert_respond_to(self, :agree)
    assert_respond_to(self, :ask)
    assert_respond_to(self, :say)
  end
  
  def test_redirection
    $terminal = HighLine.new(nil, (output = StringIO.new))
    say("Testing...")
    assert_equal("Testing...\n", output.string)
  end
end
