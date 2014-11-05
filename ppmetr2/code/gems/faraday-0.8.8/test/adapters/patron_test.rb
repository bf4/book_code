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
  class Patron < Faraday::TestCase

    def adapter() :patron end

    Integration.apply(self, :NonParallel) do
      # https://github.com/toland/patron/issues/34
      undef :test_PATCH_send_url_encoded_params

      # https://github.com/toland/patron/issues/52
      undef :test_GET_with_body
    end unless jruby?

  end
end
