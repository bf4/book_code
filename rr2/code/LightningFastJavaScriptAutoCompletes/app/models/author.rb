#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Author
  attr_accessor :name
  def initialize(name)
    @name = name    
  end
  def self.find(*args)
    [new( "Dave Thomas"), new( "Andrew Hunt"), new( "Mike Clark"), new( "Chad Fowler"), new("Esther Derby"), new("Will Gwatney"), new("Caleb Tennis"), new("Johanna Rothman"), new("Mike Gunderloy"), new("Jared Richardson"), new("Mike Mason")]
  end
end