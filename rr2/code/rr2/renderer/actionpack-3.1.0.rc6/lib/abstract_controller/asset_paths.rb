#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module AbstractController
  module AssetPaths
    extend ActiveSupport::Concern

    included do
      config_accessor :asset_host, :asset_path, :assets_dir, :javascripts_dir, :stylesheets_dir
    end
  end
end
