#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "action_view"
require "rails"

module ActionView
  # = Action View Railtie
  class Railtie < Rails::Railtie
    config.action_view = ActiveSupport::OrderedOptions.new
    config.action_view.stylesheet_expansions = {}
    config.action_view.javascript_expansions = { :defaults => %w(jquery jquery_ujs) }

    initializer "action_view.cache_asset_ids" do |app|
      unless app.config.cache_classes
        ActiveSupport.on_load(:action_view) do
          ActionView::Helpers::AssetTagHelper::AssetPaths.cache_asset_ids = false
        end
      end
    end

    initializer "action_view.javascript_expansions" do |app|
      ActiveSupport.on_load(:action_view) do
        ActionView::Helpers::AssetTagHelper.register_javascript_expansion(
          app.config.action_view.delete(:javascript_expansions)
        )

        ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion(
          app.config.action_view.delete(:stylesheet_expansions)
        )
      end
    end

    initializer "action_view.set_configs" do |app|
      ActiveSupport.on_load(:action_view) do
        app.config.action_view.each do |k,v|
          send "#{k}=", v
        end
      end
    end

    initializer "action_view.caching" do |app|
      ActiveSupport.on_load(:action_view) do
        if app.config.action_view.cache_template_loading.nil?
          ActionView::Resolver.caching = app.config.cache_classes
        end
      end
    end
  end
end
