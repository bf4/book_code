#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
module KnowsTheDomain
  def my_account
    @my_account ||= Account.new
  end
  
  def cash_slot
    @cash_slot ||= CashSlot.new
  end
  
  def teller
    @teller ||= Teller.new(cash_slot)
  end
end

World(KnowsTheDomain)
