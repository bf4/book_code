#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
names = ['bob', 'bill', 'heather']
names.map {|name| name.capitalize }   # => ["Bob", "Bill", "Heather"]

class Symbol
  def to_proc
    Proc.new {|x| x.send(self) }
  end
end

names = ['bob', 'bill', 'heather']
names.map(&:capitalize.to_proc)   # => ["Bob", "Bill", "Heather"]

require_relative '../test/assertions'
assert_equals ["Bob", "Bill", "Heather"], names.map(&:capitalize.to_proc)

names = ['bob', 'bill', 'heather']
names.map(&:capitalize)   # => ["Bob", "Bill", "Heather"]

assert_equals ["Bob", "Bill", "Heather"], names.map(&:capitalize)
