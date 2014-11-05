#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'hashie/hash_extensions'

module Hashie
  # A Hashie Hash is simply a Hash that has convenience
  # functions baked in such as stringify_keys that may
  # not be available in all libraries.
  class Hash < Hash
    include Hashie::HashExtensions

    # Converts a mash back to a hash.
    def to_hash(options = {})
      out = {}
      keys.each do |k|
        key = options[:symbolize_keys] ? k.to_sym : k.to_s
        out[key] = Hashie::Hash === self[k] ? self[k].to_hash : self[k]
      end
      out
    end

    # The C geneartor for the json gem doesn't like mashies
    def to_json(*args)
      to_hash.to_json(*args)
    end
  end
end
