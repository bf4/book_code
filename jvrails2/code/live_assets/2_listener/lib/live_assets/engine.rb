#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module LiveAssets
  class Engine < ::Rails::Engine
    initializer "live_assets.start_listener" do |app|
      paths = app.paths["app/assets"].existent +
              app.paths["lib/assets"].existent +
              app.paths["vendor/assets"].existent

      paths = paths.select { |p| p =~ /stylesheets/ }

      if app.config.assets.compile
        LiveAssets.start_listener :reloadCSS, paths
      end
    end
  end
end
