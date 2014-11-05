#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Loan
  def initialize(book)
    @book = book
    @time = Time.now
  end
  
  def to_s
    "#{@book.upcase} loaned on #{@time}"
  end
end

class Loan
  def initialize(book)
    @book = book
    @time = Loan.time_class.now
  end
  
  def self.time_class
    @time_class || Time
  end
  
  def to_s
    # ...
    "#{@book.upcase} loaned on #{@time}"
  end
end

class FakeTime
  def self.now; 'Mon Apr 06 12:15:50'; end
end

require 'test/unit'

class TestLoan < Test::Unit::TestCase
  def test_conversion_to_string
    Loan.instance_eval { @time_class = FakeTime }
    loan = Loan.new('War and Peace')
    assert_equal 'WAR AND PEACE loaned on Mon Apr 06 12:15:50', loan.to_s
  end
end
