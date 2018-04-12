#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'account'
require 'support/matchers'

RSpec.describe '`have_a_balance_of(amount)`' do
  let(:account) { Account.new('Checking') }

  before do
    account.expenses << Expense.new(Date.new(2017, 6, 10), 10_000_000.5)
    account.expenses << Expense.new(Date.new(2017, 6, 15), 500_000.4)
  end

  it 'passes when the balances match' do
    expect(account).to have_a_balance_of(a_value < 11_000_000)
    # or
    expect(account).to have_a_balance_of(a_value_within(50).of(10_500_000))
  end

  it 'fails when the balance does not match' do
    expect(account).to have_a_balance_of(a_value_within(1).of(10_499_999))
  end
end
