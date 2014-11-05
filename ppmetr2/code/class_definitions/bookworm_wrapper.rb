#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Amazon
  def reviews_of(book); ['one', 'two'] end
end

module AmazonWrapper
  def reviews_of(book)
    start = Time.now
    result = super
    time_taken = Time.now - start
    puts "reviews_of() took more than #{time_taken} seconds" if time_taken > 2
    result
  rescue
    puts "reviews_of() failed"
    []
  end
end

Amazon.class_eval do
  prepend AmazonWrapper
end

def deserves_a_look?(book)
  amazon = Amazon.new
  amazon.reviews_of(book).size > 20
end

require_relative '../test/assertions'
assert_false deserves_a_look? Object.new
