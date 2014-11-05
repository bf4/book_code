#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ReceiptMailer < ActionMailer::Base
  class << self
    def send_receipt_if_opted_in(order)
       if order.customer && order.customer.email_opt_in?
         receipt(order).deliver
       end
    end
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.receipt_mailer.receipt.subject
  #
  def receipt(order)
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
