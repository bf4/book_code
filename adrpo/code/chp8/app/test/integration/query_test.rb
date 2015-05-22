#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
require 'test_helper'
require 'assert_value'

class QueryTest < ActionDispatch::IntegrationTest

  def test_loading_things
    ActiveRecord::Base.connection.execute <<-END
      insert into things(col0, col1, col2, col3, col4,
                         col5, col6, col7, col8, col9) (
        select
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
        rpad('x', 100, 'x')
        from generate_series(1, 10000)
      );
    END

    queries = track_queries do
      get "/"
    end
=begin
    assert_value queries
=end
    assert_value queries.join("\n"), <<-END
        Thing Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
        Minion Load
    END
    queries = track_queries do
      get "/", preload: true
    end
    assert_value queries.join("\n"), <<-END
        Thing Load
        Minion Load
    END
  end

private

  def track_queries
    result = []
    ActiveSupport::Notifications.subscribe "sql.active_record" do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
      query_name = event.payload[:name]
      next if ['SCHEMA'].include?(query_name) # skip AR schema lookups
      result << query_name
    end
    yield
    ActiveSupport::Notifications.unsubscribe("sql.active_record")
    result
  end

end
