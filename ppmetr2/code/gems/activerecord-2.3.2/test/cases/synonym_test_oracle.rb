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
require 'models/subject'

# confirm that synonyms work just like tables; in this case
# the "subjects" table in Oracle (defined in oci.sql) is just
# a synonym to the "topics" table

class TestOracleSynonym < ActiveRecord::TestCase

  def test_oracle_synonym
    topic = Topic.new
    subject = Subject.new
    assert_equal(topic.attributes, subject.attributes)
  end

end
