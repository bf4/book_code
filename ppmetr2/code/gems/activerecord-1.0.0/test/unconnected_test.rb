#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class TestRecord < ActiveRecord::Base
end

class TestUnconnectedAdaptor < Test::Unit::TestCase

  def setup
    @connection = ActiveRecord::Base.remove_connection
  end

  def teardown
    ActiveRecord::Base.establish_connection(@connection)
  end

  def test_unconnected
    assert_raise(ActiveRecord::ConnectionNotEstablished) do
      TestRecord.find(1)   
    end
    assert_raise(ActiveRecord::ConnectionNotEstablished) do
      TestRecord.new.save   
    end
  end
end
