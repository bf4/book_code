#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require 'active_record'
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', 
                                        :database => 'db/bank.db')
ActiveRecord::Migrator.migrate("db/migrate/")
class Account < ActiveRecord::Base
  validates_uniqueness_of :number
  def queue
    @queue ||= TransactionQueue.new
  end
  def credit(amount)
    queue.write("+#{amount},#{number}")
  end
  def debit(amount)
    queue.write("-#{amount},#{number}")
  end
end

