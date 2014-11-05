#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"

class FirebirdConnectionTest < ActiveRecord::TestCase
  def test_charset_properly_set
    fb_conn = ActiveRecord::Base.connection.instance_variable_get(:@connection)
    assert_equal 'UTF8', fb_conn.database.character_set
  end
end
