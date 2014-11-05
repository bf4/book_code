#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
require 'helper'

class BootTest < MiniTest::Unit::TestCase
  def setup
    spyglass
  end
  
  def test_it_boots
    # If this returns `nil` then our process is still running, meaning
    # it hasn't crashed!
    refute Process.waitpid(@pid, Process::WNOHANG)
  end
end
