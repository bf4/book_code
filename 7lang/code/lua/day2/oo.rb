#---
# Excerpted from "Seven More Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7lang for more book information.
#---
# RUBY!!! Not Lua!
class Villain
  def initialize(name, health)
    @name   = name
    @health = health
  end

  def health
    return @health
  end

  def take_hit
    @health = @health - 10
  end
end

# Still not Lua!
emperor = Villain.new("Emperor", 100)
clone   = Villain.new("Emperor", 100)
