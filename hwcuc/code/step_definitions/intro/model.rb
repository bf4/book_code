#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
class Bank
  def method_missing(*args)
  end
end

class Account
  def initialize(bank)
  end
  def method_missing(*args)
  end
end

class DebitCard
  def initialize(account)
  end
  def method_missing(*args)
  end
end

class AtmAutomator
  def initialize(bank)
  end
  def card_withheld?
    true
  end
  def message_on_screen
    "Please contact the bank."
  end
  def method_missing(*args)
  end
end

