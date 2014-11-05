#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
$: << File.dirname(__FILE__)

require "rubygems"
require "active_record"

require 'connect'

ActiveRecord::Base.logger = Logger.new(STDERR)

ActiveRecord::Schema.define do 
  create_table :payments, :force => true do |t|
  end
end

class Order < ActiveRecord::Base
end

class Payment < ActiveRecord::Base
end

class Refund < ActiveRecord::Base
end

class OrderObserver < ActiveRecord::Observer
  def after_save(an_order)
    an_order.logger.info("Order #{an_order.id} created")
  end
end

OrderObserver.instance

class AuditObserver < ActiveRecord::Observer
  observe Order, Payment, Refund
  def after_save(model)
    model.logger.info("[Audit] #{model.class.name} #{model.id} created")
  end
end

AuditObserver.instance


o = Order.create
p = Payment.create

