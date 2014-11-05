#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
class Account
  def credit(amount)
    @balance = amount
  end

  def balance
    @balance
  end

  def debit(amount)
    @balance -= amount
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
