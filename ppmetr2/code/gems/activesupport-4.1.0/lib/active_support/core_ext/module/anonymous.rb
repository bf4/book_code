#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Module
  # A module may or may not have a name.
  #
  #   module M; end
  #   M.name # => "M"
  #
  #   m = Module.new
  #   m.name # => nil
  #
  # A module gets a name when it is first assigned to a constant. Either
  # via the +module+ or +class+ keyword or by an explicit assignment:
  #
  #   m = Module.new # creates an anonymous module
  #   M = m          # => m gets a name here as a side-effect
  #   m.name         # => "M"
  def anonymous?
    name.nil?
  end
end
