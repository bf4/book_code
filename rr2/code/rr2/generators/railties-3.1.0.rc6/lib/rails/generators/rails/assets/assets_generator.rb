#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module Rails
  module Generators
    class AssetsGenerator < NamedBase
      class_option :javascripts, :type => :boolean, :desc => "Generate JavaScripts"
      class_option :stylesheets, :type => :boolean, :desc => "Generate Stylesheets"

      class_option :javascript_engine, :desc => "Engine for JavaScripts"
      class_option :stylesheet_engine, :desc => "Engine for Stylesheets"

      protected

      def asset_name
        file_name
      end

      hook_for :javascript_engine do |javascript_engine|
        invoke javascript_engine, [name] if options[:javascripts]
      end

      hook_for :stylesheet_engine do |stylesheet_engine|
        invoke stylesheet_engine, [name] if options[:stylesheets]
      end
    end
  end
end
