#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"

class MongoMetricsTest < ActiveSupport::TestCase
  setup { MongoMetrics::Metric.delete_all }

  test "process_action notification is saved in the mongo database" do
    event   = "process_action.action_controller"
    payload = { "path" => "/" }

    ActiveSupport::Notifications.instrument event, payload do
      sleep(0.001) # simulate work
    end

    metric = MongoMetrics::Metric.first
    assert_equal 1, MongoMetrics::Metric.count
    assert_equal event, metric.name
    assert_equal "/", metric.payload["path"]

    assert metric.duration
    assert metric.instrumenter_id
    assert metric.started_at
    assert metric.created_at
  end

  test 'can ignore notifications when specified' do
    MongoMetrics.mute! do
      assert MongoMetrics.mute?
      event = "process_action.action_controller"
      ActiveSupport::Notifications.instrument event do
        sleep(0.001) # simulate work
      end
    end
    assert !MongoMetrics.mute?
    assert_equal 0, MongoMetrics::Metric.count
  end

  test 'does not leak mute state on failures' do
    MongoMetrics.mute! do
      assert MongoMetrics.mute?
      raise "oops"
    end rescue nil

    assert !MongoMetrics.mute?
  end
end
