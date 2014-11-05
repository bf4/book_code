#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require "cases/helper"
require 'models/topic'

class TestColumnAlias < ActiveRecord::TestCase
  fixtures :topics

  QUERY = if 'Oracle' == ActiveRecord::Base.connection.adapter_name
            'SELECT id AS pk FROM topics WHERE ROWNUM < 2'
          else
            'SELECT id AS pk FROM topics'
          end

  def test_column_alias
    records = Topic.connection.select_all(QUERY)
    assert_equal 'pk', records[0].keys[0]
  end
end
