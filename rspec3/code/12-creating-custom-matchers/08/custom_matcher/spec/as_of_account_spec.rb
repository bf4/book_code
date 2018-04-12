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
    account.expenses << Expense.new(Date.new(2017, 6, 10), 10)
    account.expenses << Expense.new(Date.new(2017, 6, 15), 20)
  end

  it 'passes when the balances match' do
    expect(account).to have_a_balance_of(30)
    # or
    expect(account).to have_a_balance_of(10).as_of(Date.new(2017, 6, 12))
  end

  it "fails when a date's balance does not match" do
    expect(account).to have_a_balance_of(15).as_of(Date.new(2017, 6, 12))
  end

  it 'can be used in a compound expression' do
    # rubocop:disable Style/FirstParameterIndentation
    expect(account).to have_a_balance_of(30).and \
                       have_attributes(name: 'Checking')
    # rubocop:disable Style/FirstParameterIndentation
  end

  it 'can be passed to another matcher' do
    user_accounts = [account]

    expect(user_accounts).to include(an_account_with_a_balance_of(30))
  end
end
