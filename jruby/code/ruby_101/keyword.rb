#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
def bio(details)
  for key, value in details
    puts "My #{key} is #{value}."
  end
end

bio :name     => "Nick",
    :location => "Minneapolis",
    :drink    => "tea",
    :quest    => "JRuby"

# Prints:
#   My name is Nick.
#   My location is Minneapolis.
#   My drink is tea.
#   My quest is JRuby.
