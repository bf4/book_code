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

transaction_queue = TransactionQueue.new
balance_store = BalanceStore.new

puts "transaction processor ready"
loop do
  transaction_queue.read do |message|
    sleep 1
    transaction_amount = message.to_i
    new_balance = balance_store.balance + transaction_amount
    balance_store.balance = new_balance
  end
end
