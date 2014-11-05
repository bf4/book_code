#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
# This class represents an ecommerce order
class Order
  attr_accessor :amount, :status

  def initialize(amount, status)
    @amount, @status = amount, status
  end

  def pending?
    status == 'pending'
  end
  
  def collect_payment
    puts "Collecting payment..."
    self.status = 'paid'
  end
end

# Create a pending order for $100
order = Order.new(100.00, 'pending')
mutex = Mutex.new

# Ask 5 threads to check the status, and collect
# payment if it's 'pending'
5.times.map do
  Thread.new do
    mutex.synchronize do
      if order.pending?
        order.collect_payment
      end
    end
  end
end.each(&:join)

