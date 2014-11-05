#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
module KnowsTheUserInterface

  class UserInterface
    include Capybara::DSL

    def withdraw_from(account, amount)
      Sinatra::Application.account = account
      visit '/'
      fill_in 'Amount', :with => amount
      click_button 'Withdraw'
    end
  end

  def my_account
    @my_account ||= Account.new
  end

  def cash_slot
    Sinatra::Application.cash_slot
  end

  def teller
    @teller ||= UserInterface.new
  end

end

World(KnowsTheUserInterface)
