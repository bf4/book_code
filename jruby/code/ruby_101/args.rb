#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def you_gave_me(present = nil)
  present
end

you_gave_me          # => nil
you_gave_me "a pony" # => "a pony"

def area(width = 10, height = 2 * width)
  width * height
end

area       # => 200
area 5     # => 50
area 5, 20 # => 100

def quote(person, *words)
  person + ' says: "' + words.join(' ') + '"'
end

quote 'Ola'                    # => "Ola says: \"\""
quote 'Ola', 'keep', 'coding!' # => "Ola says: \"keep coding!\""

def something(needs, three, arguments)
  'Yay!'
end

my_array = ['one', 'two', 'three']

something(my_array)  # ~> ArgumentError
something(*my_array) # => 'Yay'
