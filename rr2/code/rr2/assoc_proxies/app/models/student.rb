#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "grade_finder"
class Student < ActiveRecord::Base
  has_many :grades, :extend => GradeFinder 
end
class Student < ActiveRecord::Base
  has_many :grades
end
class Student < ActiveRecord::Base
  has_many :grades do 
    def below_average
      where('score < ?', 2)
    end
  end
end
