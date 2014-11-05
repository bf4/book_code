#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'vcr/middleware/excon'

Excon.defaults[:middlewares] << VCR::Middleware::Excon

VCR.configuration.after_library_hooks_loaded do
  # ensure WebMock's Excon adapter does not conflict with us here
  # (i.e. to double record requests or whatever).
  if defined?(WebMock::HttpLibAdapters::ExconAdapter)
    WebMock::HttpLibAdapters::ExconAdapter.disable!
  end
end

