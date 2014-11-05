#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require_relative 'transaction_queue'
require_relative 'balance_store'
class Account
  def initialize
    @queue = TransactionQueue.new
    @balance_store = BalanceStore.new
  end

  def balance
    @balance_store.balance
  end

  def credit(amount)
    @queue.write("+#{amount}")
  end

  def debit(amount)
    @queue.write("-#{amount}")
  end
end

class Teller
  def initialize(cash_slot)
    @cash_slot = cash_slot
  end
  
  def withdraw_from(account, amount)
    account.debit(amount)
    @cash_slot.dispense(amount)
  end
end

class CashSlot
  def contents
    @contents or raise("I'm empty!")
  end
  
  def dispense(amount)
    @contents = amount
  end
end

require 'sinatra'

get '/' do
  %{
  <html>
    <body>
      <p>Your balance is <span class="balance">#{settings.account.balance}</span></p>
      <form action="/withdraw" method="post">
        <label for="amount">Amount</label>
        <input type="text" id="amount" name="amount">
        <button type="submit">Withdraw</button>
      </form>
    </body>
  </html>
  }
end

set :cash_slot, CashSlot.new
set :account do
  fail 'account has not been set'
end

post '/withdraw' do
  teller = Teller.new(settings.cash_slot)
  teller.withdraw_from(settings.account, params[:amount].to_i)
end

