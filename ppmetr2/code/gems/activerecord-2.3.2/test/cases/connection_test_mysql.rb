#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"

class MysqlConnectionTest < ActiveRecord::TestCase
  def setup
    super
    @connection = ActiveRecord::Base.connection
  end

  def test_mysql_reconnect_attribute_after_connection_with_reconnect_true
    run_without_connection do |orig_connection|
      ActiveRecord::Base.establish_connection(orig_connection.merge({:reconnect => true}))
      assert ActiveRecord::Base.connection.raw_connection.reconnect
    end
  end

  def test_mysql_reconnect_attribute_after_connection_with_reconnect_false
    run_without_connection do |orig_connection|
      ActiveRecord::Base.establish_connection(orig_connection.merge({:reconnect => false}))
      assert !ActiveRecord::Base.connection.raw_connection.reconnect
    end
  end

  def test_no_automatic_reconnection_after_timeout
    assert @connection.active?
    @connection.update('set @@wait_timeout=1')
    sleep 2
    assert !@connection.active?
  end

  def test_successful_reconnection_after_timeout_with_manual_reconnect
    assert @connection.active?
    @connection.update('set @@wait_timeout=1')
    sleep 2
    @connection.reconnect!
    assert @connection.active?
  end

  def test_successful_reconnection_after_timeout_with_verify
    assert @connection.active?
    @connection.update('set @@wait_timeout=1')
    sleep 2
    @connection.verify!
    assert @connection.active?
  end

  private

  def run_without_connection
    original_connection = ActiveRecord::Base.remove_connection
    begin
      yield original_connection
    ensure
      ActiveRecord::Base.establish_connection(original_connection)
    end
  end
end
