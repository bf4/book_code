#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class Ticket < ApplicationRecord

  has_paper_trail

  include HasReference

  belongs_to :user, optional: true
  belongs_to :performance
  has_one :event, through: :performance
  monetize :price_cents

  enum status: {unsold: 0, waiting: 1, purchased: 2, pending: 3,
                refund_pending: 4, refunded: 5}
  enum access: {general: 0}

  def place_in_cart_for(user)
    update(status: :waiting, user: user)
  end

  def refund_successful
    refunded!
    new_ticket = dup
    new_ticket.unsold!
  end

end
