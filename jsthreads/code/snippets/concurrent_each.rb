#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
module Enumerable
  def concurrent_each
    threads = []

    each do |element|
      threads << Thread.new {
        yield element
      }
    end

    threads.each(&:join)
  end
end

