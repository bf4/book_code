#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module ActiveRecord
  class Railtie < Rails::Railtie
    config.active_record = ActiveSupport::OrderedOptions.new
    config.app_generators.orm :active_record, migration: true,
                                              timestamps: true
    config.app_middleware.insert_after "::ActionDispatch::Callbacks",
      "ActiveRecord::QueryCache"
    config.eager_load_namespaces << ActiveRecord
    rake_tasks do
      require "active_record/base"
      load "active_record/railties/databases.rake"
    end
    runner do
      require "active_record/base"
    end
    initializer "active_record.initialize_timezone" do
      ActiveSupport.on_load(:active_record) do
        self.time_zone_aware_attributes = true
        self.default_timezone = :utc
      end
    end
    initializer "active_record.migration_error" do
      if config.active_record.delete(:migration_error) == :page_load
        config.app_middleware.insert_after "::ActionDispatch::Callbacks",
          "ActiveRecord::Migration::CheckPending"
      end
    end
  end
end
