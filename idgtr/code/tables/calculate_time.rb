#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'rubygems'

require 'fit/column_fixture'
require 'calculator'
class CalculateTime < Fit::ColumnFixture
  def initialize
    @calc = Calculator.single
    @days = @hours = @mins = @secs = nil
  end
end

class CalculateTime
  attr_accessor :days, :hours, :mins
  attr_reader :secs

  def secs=(value)
    @secs = value
    
    @calc.enter_time @days, @hours, @mins, @secs
    @calc.plus
    @calc.enter_number 0
    @calc.equals
    
    @days, @hours, @mins, @secs = @calc.time
  end
end
