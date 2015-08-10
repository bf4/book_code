#---
# Excerpted from "Rails, Angular, Postgres, and Bootstrap",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dcbang for more book information.
#---
module Jasmine
  module Core
    class << self
      def path
        File.join(File.dirname(__FILE__), "jasmine-core")
      end

      def js_files
        (["jasmine.js"] + Dir.glob(File.join(path, "*.js"))).map { |f| File.basename(f) }.uniq
      end

      SPEC_TYPES = ["core", "html", "node"]

      def core_spec_files
        spec_files("core")
      end

      def html_spec_files
        spec_files("html")
      end

      def node_spec_files
        spec_files("node")
      end

      def spec_files(type)
        raise ArgumentError.new("Unrecognized spec type") unless SPEC_TYPES.include?(type)
        (Dir.glob(File.join(path, "spec", type, "*.js"))).map { |f| File.join("spec", type, File.basename(f)) }.uniq
      end

      def css_files
        Dir.glob(File.join(path, "*.css")).map { |f| File.basename(f) }
      end
    end
  end
end
