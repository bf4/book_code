#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
#
# Manages current Padrino version for use in gem generation.
#
# We put this in a separate file so you can get padrino version
# without include full padrino core.
#
module Padrino
  # The version constant for the current version of Padrino.
  VERSION = '0.11.3' unless defined?(Padrino::VERSION)

  #
  # The current Padrino version.
  #
  # @return [String]
  #   The version number.
  #
  def self.version
    VERSION
  end
end # Padrino
