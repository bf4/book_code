#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'calculator'

shared_context 'a new calculator' do
  before do
    @calc = Calculator.single
    @calc.clear
  end
end

module AdditionHelper
  def add_and_check(number, result)
    @calc.enter_number number
    @calc.equals
    @calc.total_seconds.should == result
  end
end

describe 'Starting with 1' do
  include AdditionHelper
  include_context 'a new calculator'
  before do
    @calc.enter_number 1
    @calc.plus
  end

  it 'should add 0 correctly' do
    add_and_check(0, 1)
  end

  it 'should add 1 correctly' do
    add_and_check(1, 2)
  end
  # two more nearly-identical examples
end
