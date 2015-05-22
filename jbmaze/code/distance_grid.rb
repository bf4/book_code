#---
# Excerpted from "Mazes for Programmers",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jbmaze for more book information.
#---
require 'grid'

class DistanceGrid < Grid
  attr_accessor :distances

  def contents_of(cell)
    if distances && distances[cell]
      distances[cell].to_s(36)
    else
      super
    end
  end
end
