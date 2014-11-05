#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Local Rake override to fix bug in Ruby 0.8.2
module Test                     # :nodoc:
  # Local Rake override to fix bug in Ruby 0.8.2
  module Unit                   # :nodoc:
    # Local Rake override to fix bug in Ruby 0.8.2
    module Collector            # :nodoc:
      # Local Rake override to fix bug in Ruby 0.8.2
      class Dir                 # :nodoc:
        undef collect_file
        def collect_file(name, suites, already_gathered) # :nodoc:
          dir = File.dirname(File.expand_path(name))
          $:.unshift(dir) unless $:.first == dir
          if(@req)
            @req.require(name)
          else
            require(name)
          end
          find_test_cases(already_gathered).each{|t| add_suite(suites, t.suite)}
        ensure
          $:.delete_at $:.rindex(dir)
        end
      end
    end
  end
end
