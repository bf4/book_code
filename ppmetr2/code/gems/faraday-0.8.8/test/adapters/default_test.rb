#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path('../integration', __FILE__)

module Adapters
  class DefaultTest < Faraday::TestCase

    def adapter() :default end

    Integration.apply(self, :NonParallel) do
      # default stack is not configured with Multipart
      undef :test_POST_sends_files
    end

  end
end
