#---
# Excerpted from "Take My Money",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrwebpay for more book information.
#---
class Performance < ApplicationRecord

  has_paper_trail

  belongs_to :event
  has_many :tickets

  def unsold_tickets(count)
    tickets.where(status: "unsold").limit(count)
  end

  def name
    "#{event.name} #{start_time.to_s(:short)}"
  end

end
