#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'fileutils'

module VCR
  class Cassette
    class Persisters
      # The only built-in cassette persister. Persists cassettes to the file system.
      module FileSystem
        extend self

        # @private
        attr_reader :storage_location

        # @private
        def storage_location=(dir)
          FileUtils.mkdir_p(dir) if dir
          @storage_location = dir ? absolute_path_for(dir) : nil
        end

        # Gets the cassette for the given storage key (file name).
        #
        # @param [String] file_name the file name
        # @return [String] the cassette content
        def [](file_name)
          path = absolute_path_to_file(file_name)
          return nil unless File.exist?(path)
          File.read(path)
        end

        # Sets the cassette for the given storage key (file name).
        #
        # @param [String] file_name the file name
        # @param [String] content the content to store
        def []=(file_name, content)
          path = absolute_path_to_file(file_name)
          directory = File.dirname(path)
          FileUtils.mkdir_p(directory) unless File.exist?(directory)
          File.open(path, 'w') { |f| f.write(content) }
        end

        # @private
        def absolute_path_to_file(file_name)
          return nil unless storage_location
          File.join(storage_location, sanitized_file_name_from(file_name))
        end

      private

        def absolute_path_for(path)
          Dir.chdir(path) { Dir.pwd }
        end

        def sanitized_file_name_from(file_name)
          parts = file_name.to_s.split('.')
          file_extension = '.' + parts.pop if parts.size > 1
          parts.join('.').gsub(/[^\w\-\/]+/, '_') + file_extension.to_s
        end
      end
    end
  end
end
