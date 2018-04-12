desc "Refreshes materialized views"
task refresh_materialized_views: :environment do
  ActiveRecord::Base.connection.execute %{
    REFRESH MATERIALIZED VIEW CONCURRENTLY customer_details
  }
end
