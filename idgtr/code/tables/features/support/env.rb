#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
$: << File.join(File.dirname(__FILE__), '../..')

require 'calculator'
require 'rubygems'
require 'rspec'

class CalcWorld
  Constants = {:huge => 2**63 - 2, :huger => 2**63 - 1, :over => 0}

  def number_for(value)
    Constants[value.to_s.intern] || value.to_s.to_i
  end
end

World {CalcWorld.new}

at_exit {Calculator.single.off}
