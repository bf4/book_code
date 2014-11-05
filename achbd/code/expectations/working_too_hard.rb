#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
# re_read_the_bit_about :sustainable_pace if working_too_hard? 

def weeks
  [1,2,3]
end

class Person
  def initialize(hours)
    @hours = hours
  end
  def hours_for(week)
    @hours
  end
end

def people
  [
    Person.new(49),
    Person.new(50),
    Person.new(51),
    Person.new(52)
  ]
end

def working_too_hard? 
  weeks.each do |week| 
    people.each do |person|
      return true if person.hours_for(week) > 50
    end 
  end 
end

puts working_too_hard?

# def working_too_hard? 
#   catch :working_too_hard do 
#     weeks.each do |week| 
#       people.each do |person|
#         throw :working_too_hard, true if person.hours_for(week) > 50
#       end
#     end
#   end
# end
# 
# puts working_too_hard?