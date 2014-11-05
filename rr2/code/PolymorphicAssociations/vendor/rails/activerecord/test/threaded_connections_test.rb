#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'
require 'fixtures/topic'

class ThreadedConnectionsTest < Test::Unit::TestCase
  self.use_transactional_fixtures = false

  fixtures :topics

  def setup
    @connection = ActiveRecord::Base.remove_connection
    @connections = []
    @allow_concurrency = ActiveRecord::Base.allow_concurrency
  end
  
  def teardown
    # clear the connection cache
    ActiveRecord::Base.send(:clear_all_cached_connections!)
    # set allow_concurrency to saved value
    ActiveRecord::Base.allow_concurrency = @allow_concurrency
    # reestablish old connection
    ActiveRecord::Base.establish_connection(@connection)
  end
  
  def gather_connections(use_threaded_connections)
    ActiveRecord::Base.allow_concurrency = use_threaded_connections
    ActiveRecord::Base.establish_connection(@connection)
    
    5.times do
      Thread.new do
        Topic.find :first
        @connections << ActiveRecord::Base.active_connections.values.first
      end.join
    end
  end

  def test_threaded_connections
    gather_connections(true)
    assert_equal @connections.uniq.length, 5
  end

  def test_unthreaded_connections
    gather_connections(false)
    assert_equal @connections.uniq.length, 1
  end
end
