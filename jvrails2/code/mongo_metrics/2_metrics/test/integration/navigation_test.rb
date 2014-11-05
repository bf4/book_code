#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"
class NavigationTest < ActionDispatch::IntegrationTest
  setup { MongoMetrics::Metric.delete_all }

  test "can visualize notifications" do
    get main_app.home_foo_path
    get main_app.home_bar_path
    get main_app.home_baz_path

    get mongo_metrics.root_path
    assert_match "Path: /home/foo", response.body
    assert_match "Path: /home/bar", response.body
    assert_match "Path: /home/baz", response.body
  end

  test "can destroy notifications" do
    get main_app.home_foo_path
    metric = MongoMetrics::Metric.first
    delete mongo_metrics.metric_path(metric)
    assert_empty MongoMetrics::Metric.where(id: metric.id)
  end
end
