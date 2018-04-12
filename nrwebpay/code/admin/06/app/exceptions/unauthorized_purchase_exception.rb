#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class UnauthorizedPurchaseException < StandardError

  attr_accessor :message, :user, :expected_purchase_cents, :expected_ticket_ids

  def initialize(message = nil, user:)
    super(message)
    @user = user
  end

end
