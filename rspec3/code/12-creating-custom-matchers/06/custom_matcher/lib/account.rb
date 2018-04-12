#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'date'

Account = Struct.new(:name) do
  def expenses
    @expenses ||= []
  end

  def current_balance
    calculate_balance(expenses)
  end

  def balance_as_of(date)
    calculate_balance(expenses.select { |e| e.date <= date })
  end

  def to_s
    super.sub('struct ', '')
  end
  alias_method :inspect, :to_s

private

  def calculate_balance(expenses)
    expenses.map(&:amount).inject(0, :+)
  end
end

Expense = Struct.new(:date, :amount)
