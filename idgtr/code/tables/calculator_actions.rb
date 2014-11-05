#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'fit/fixture'
require 'calculator'

class CalculatorActions < Fit::Fixture
  def initialize
    @calc = Calculator.single
  end
  
  def number(value)
    @calc.enter_number value
  end
  
  [:plus, :equals, :total_seconds].each do |name|
    define_method(name) do
      @calc.send name
    end
  end
end
