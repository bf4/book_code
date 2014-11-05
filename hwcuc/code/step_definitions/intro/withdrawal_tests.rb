#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require File.dirname(__FILE__) + '/model'
require 'test/unit'
class WithdrawalTests < Test::Unit::TestCase
  def test_attempt_widthrawl_using_stolen_card
    bank = Bank.new
    account = Account.new(bank)
    account.deposit(100)
    card = DebitCard.new(account)
    bank.lock_out(card)

    atm = AtmAutomator.new(bank)
    atm.insert_card(card)
    atm.enter_pin(card.pin)
    atm.withdraw(50)
    
    assert atm.card_withheld?, "Expected the card to be withheld by the ATM"
    assert_equal "Please contact the bank.", atm.message_on_screen
  end
end
