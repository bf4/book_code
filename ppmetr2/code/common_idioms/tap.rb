#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  def tap
    yield self
    self
  end
end

['a', 'b', 'c'].push('d').shift.upcase.next # => "B"

temp = ['a', 'b', 'c'].push('d').shift
puts temp
x = temp.upcase.next

['a', 'b', 'c'].push('d').shift.tap {|x| puts x }.upcase.next
# >> a
