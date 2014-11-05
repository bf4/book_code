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
require 'fixtures/subscriber'
require 'fixtures/movie'

class PrimaryKeysTest < Test::Unit::TestCase
  def setup
    @topics      = create_fixtures "topics"
    @subscribers = create_fixtures "subscribers"
    @movies      = create_fixtures "movies"
  end

  def test_integer_key
    topic = Topic.find(1)
    assert_equal(@topics["first"]["author_name"], topic.author_name)
    topic = Topic.find(2)
    assert_equal(@topics["second"]["author_name"], topic.author_name)

    topic = Topic.new
    topic.title = "New Topic"
    topic.save
    id = topic.id

    topicReloaded = Topic.find(id)
    assert_equal("New Topic", topicReloaded.title)
  end

  def test_string_key
    subscriber = Subscriber.find(@subscribers["first"]["nick"])
    assert_equal(@subscribers["first"]["name"], subscriber.name)
    subscriber = Subscriber.find(@subscribers["second"]["nick"])
    assert_equal(@subscribers["second"]["name"], subscriber.name)

    subscriber = Subscriber.new
    subscriber.id = "jdoe"
    subscriber.name = "John Doe"
    subscriber.save

    subscriberReloaded = Subscriber.find("jdoe")
    assert_equal("John Doe", subscriberReloaded.name)
  end

  def test_find_with_more_than_one_string_key
    assert_equal 2, Subscriber.find(@subscribers["first"]["nick"], @subscribers["second"]["nick"]).length
  end
  
  def test_primary_key_prefix
    ActiveRecord::Base.primary_key_prefix_type = :table_name
    assert_equal "topicid", Topic.primary_key

    ActiveRecord::Base.primary_key_prefix_type = :table_name_with_underscore
    assert_equal "topic_id", Topic.primary_key

    ActiveRecord::Base.primary_key_prefix_type = nil
    assert_equal "id", Topic.primary_key
  end
end
