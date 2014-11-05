#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'rails/generators/named_base'
require 'rails/generators/active_model'
require 'rails/generators/active_record/migration'
require 'active_record'

module ActiveRecord
  module Generators # :nodoc:
    class Base < Rails::Generators::NamedBase # :nodoc:
      include ActiveRecord::Generators::Migration

      # Set the current directory as base for the inherited generators.
      def self.base_root
        File.dirname(__FILE__)
      end
    end
  end
end
