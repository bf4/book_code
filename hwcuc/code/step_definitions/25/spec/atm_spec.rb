#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require File.dirname(__FILE__) + '/../lib/nice_bank'

describe ATM do
  describe "#withdraw_cash" do
    let(:cash_slot) { double(CashSlot, :dispense => nil) }
    let(:account)   { double(Account,  :debit => nil)    }
    let(:atm)       { ATM.new(cash_slot) }
    let(:amount)    { 20 }

    it "tells the CashSlot to dispense cash" do
      cash_slot.should_receive(:dispense).with(amount)
      atm.withdraw_from(account, amount)
    end

    it "removes cash from the Account" do
      account.should_receive(:debit).with(amount)
      atm.withdraw_from(account, amount)
    end
  end
end
