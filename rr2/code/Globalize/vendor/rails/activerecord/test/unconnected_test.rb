#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'abstract_unit'

class TestRecord < ActiveRecord::Base
end

class TestUnconnectedAdaptor < Test::Unit::TestCase
  self.use_transactional_fixtures = false

  def setup
    @underlying = ActiveRecord::Base.connection
    @specification = ActiveRecord::Base.remove_connection
  end

  def teardown
    @underlying = nil
    ActiveRecord::Base.establish_connection(@specification)
  end

  def test_connection_no_longer_established
    assert_raise(ActiveRecord::ConnectionNotEstablished) do
      TestRecord.find(1)
    end

    assert_raise(ActiveRecord::ConnectionNotEstablished) do
      TestRecord.new.save
    end
  end

  def test_underlying_adapter_no_longer_active
    assert !@underlying.active?, "Removed adapter should no longer be active"
  end
end
