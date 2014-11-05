#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"

class ConnectionManagementTest < ActiveRecord::TestCase
  def setup
    @env = {}
    @app = stub('App')
    @management = ActiveRecord::ConnectionAdapters::ConnectionManagement.new(@app)
    
    @connections_cleared = false
    ActiveRecord::Base.stubs(:clear_active_connections!).with { @connections_cleared = true }
  end
  
  test "clears active connections after each call" do
    @app.expects(:call).with(@env)
    @management.call(@env)
    assert @connections_cleared
  end
  
  test "doesn't clear active connections when running in a test case" do
    @env['rack.test'] = true
    @app.expects(:call).with(@env)
    @management.call(@env)
    assert !@connections_cleared
  end
end