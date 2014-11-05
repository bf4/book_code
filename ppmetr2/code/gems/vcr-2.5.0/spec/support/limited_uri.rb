#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'forwardable'

class LimitedURI
  extend Forwardable

  def_delegators :@uri, :scheme,
                        :host,
                        :port,
                        :port=,
                        :path,
                        :query,
                        :query=,
                        :to_s

  def initialize(uri)
    @uri = uri
  end

  def ==(other)
    to_s == other.to_s
  end

  def self.parse(uri)
    return uri if uri.is_a? LimitedURI
    return new(uri) if uri.is_a? URI
    return new(URI.parse(uri)) if uri.is_a? String

    raise URI::InvalidURIError
  end
end
