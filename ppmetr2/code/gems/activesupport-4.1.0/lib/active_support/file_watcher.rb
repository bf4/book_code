#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveSupport
  class FileWatcher
    class Backend
      def initialize(path, watcher)
        @watcher = watcher
        @path    = path
      end

      def trigger(files)
        @watcher.trigger(files)
      end
    end

    def initialize
      @regex_matchers = {}
    end

    def watch(pattern, &block)
      @regex_matchers[pattern] = block
    end

    def trigger(files)
      trigger_files = Hash.new { |h,k| h[k] = Hash.new { |h2,k2| h2[k2] = [] } }

      files.each do |file, state|
        @regex_matchers.each do |pattern, block|
          trigger_files[block][state] << file if pattern === file
        end
      end

      trigger_files.each do |block, payload|
        block.call payload
      end
    end
  end
end
