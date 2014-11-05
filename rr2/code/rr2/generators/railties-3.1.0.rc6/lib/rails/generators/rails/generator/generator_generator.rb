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
    class GeneratorGenerator < NamedBase
      check_class_collision :suffix => "Generator"

      class_option :namespace, :type => :boolean, :default => true,
                               :desc => "Namespace generator under lib/generators/name"

      def create_generator_files
        directory '.', generator_dir
      end

      protected

        def generator_dir
          if options[:namespace]
            File.join("lib", "generators", regular_class_path, file_name)
          else
            File.join("lib", "generators", regular_class_path)
          end
        end

    end
  end
end
