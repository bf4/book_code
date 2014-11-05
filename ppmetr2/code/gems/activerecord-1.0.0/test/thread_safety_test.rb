#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/topic'

class ThreadSafetyTest < Test::Unit::TestCase
  def setup
    @topics  = create_fixtures "topics"
    @threads = []
  end
  
  def test_threading_on_transactions
    # SQLite breaks down under thread banging
    # Jamis Buck (author of SQLite-ruby): "I know that sqlite itself is not designed for concurrent access"
    if ActiveRecord::ConnectionAdapters.const_defined? :SQLiteAdapter
      return true if ActiveRecord::Base.connection.instance_of?(ActiveRecord::ConnectionAdapters::SQLiteAdapter)
    end

    5.times do |thread_number|
      @threads << Thread.new(thread_number) do |thread_number|
        first, second = Topic.find(1, 2)
        Topic.transaction(first, second) do
          Topic.logger.info "started #{thread_number}"
          first.approved  = 1
          second.approved = 0
          first.save
          second.save
          Topic.logger.info "ended #{thread_number}"
        end
      end
    end
    
    @threads.each { |t| t.join }
  end
end
