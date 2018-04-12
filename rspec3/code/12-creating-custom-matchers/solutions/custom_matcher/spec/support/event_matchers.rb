#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
RSpec::Matchers.define :have_no_tickets_sold do
  match { |event| event.tickets_sold.count.zero? }

  failure_message do |event|
    super() + ", but had #{event.tickets_sold.count}"
  end
end

RSpec::Matchers.define :be_sold_out do
  match { |event| event.tickets_sold.count == event.capacity }

  failure_message do |event|
    unsold_count = event.capacity - event.tickets_sold.count
    super() + ", but had #{unsold_count} unsold tickets"
  end
end
