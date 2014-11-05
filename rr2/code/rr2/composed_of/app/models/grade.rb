#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Grade
  include Comparable
  attr_accessor :letter_grade
  SORT_ORDER = ["f", "d", "c", "b", "a"].inject({}) {|h, letter|
    h.update "#{letter}-" => h.size
    h.update letter => h.size
    h.update "#{letter}+" => h.size
  }
  def initialize(letter_grade)
    @letter_grade = letter_grade
  end
  def <=>(other)
    SORT_ORDER[letter_grade.downcase] <=>
      SORT_ORDER[other.letter_grade.downcase]
  end
end
