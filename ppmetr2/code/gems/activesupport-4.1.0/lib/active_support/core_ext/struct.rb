#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
#  Backport of Struct#to_h from Ruby 2.0
class Struct # :nodoc:
  def to_h
    Hash[members.zip(values)]
  end
end unless Struct.instance_methods.include?(:to_h)
