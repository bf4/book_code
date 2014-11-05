#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
at_exit {Calculator.single.off}

require 'rubygems'

require 'test/unit'
require 'test/unit/ui/console/testrunner'
require 'functional_test_matrix'
require 'rspec/expectations'

Test::Unit::TestCase.extend FunctionalTestMatrix


require 'calculator'
class CalculatorTest < Test::Unit::TestCase
  def setup
    @calc = Calculator.single #(1)
    @calc.clear
  end
end


class CalculatorTest
  Constants = {:huge => 2**63 - 2, :huge_1 => 2**63 - 1, :over => 0}

  def number_for(value) #(2)
    Constants[value.to_s.intern] || value.to_s.to_i
  end
  def matrix_init_addition(_, value)
    @seconds = number_for value
    @calc.enter_number @seconds
  end
  def matrix_setup_add(value)
    @adding = number_for value
    @calc.plus
    @calc.enter_number @adding
    @calc.equals
  end
  def matrix_test(expected)
    @calc.total_seconds.should == number_for(expected)
  end
end


class CalculatorTest
  alias_method :old_method_missing, :method_missing

  def method_missing(name, *args)
    case name.to_s
    when /matrix_setup_add_(.+)/
      matrix_setup_add $1
    when /matrix_test_(.+)/
      matrix_test $1
    else
      old_method_missing name, *args
    end
  end
end


class CalculatorTest
  matrix :addition, :to_0,   :to_1,    :to_2, :to_huge
  action :add_0,     0,      1,        2,     :huge
  action :add_1,     1,      2,        3,     :huge_1
  action :add_2,     2,      3,        4,     :over
  action :add_huge,  :huge,  :huge_1,  :over, :over
end


class CalculatorTest
  _ = :na

  matrix :addition, :to_0,   :to_1,    :to_2, :to_huge
  action :add_0,     0,      _,        _,     _
  action :add_1,     1,      2,        _,     _
  action :add_2,     2,      3,        4,     _
  action :add_huge,  :huge,  :huge_1,  :over, :over
end
