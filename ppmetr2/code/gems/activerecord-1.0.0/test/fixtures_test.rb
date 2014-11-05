#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'abstract_unit'

class FixturesTest < Test::Unit::TestCase
  def setup
    @fixtures = create_fixtures("topics")
  end

  def test_attributes
    assert_equal("The First Topic", @fixtures["first"]["title"])
    assert_nil(@fixtures["second"]["author_email_address"])
  end

  def test_inserts
    firstRow = ActiveRecord::Base.connection.select_one("SELECT * FROM topics WHERE author_name = 'David'")
    assert_equal("The First Topic", firstRow["title"])

    secondRow = ActiveRecord::Base.connection.select_one("SELECT * FROM topics WHERE author_name = 'Mary'")
    assert_nil(secondRow["author_email_address"])
  end
end
