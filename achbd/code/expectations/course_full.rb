#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Course
  def initialize(options)
    @cap = options[:seats]
    @seats = []
  end

  def register(student)
    if @seats.length >= @cap
      throw :course_full, @cap
    else
      @seats << student
    end
  end
end

class Student
end

describe Course do
  describe "#register" do
    context "when course is full" do
      it "throws :course_full" do
        course = Course.new(:seats => 20)
        20.times { course.register Student.new }
        lambda {
          course.register Student.new
        }.should throw_symbol(:course_full)
      end

      it "throws :course_full" do
        course = Course.new(:seats => 20)
        20.times { course.register Student.new }
        lambda {
          course.register Student.new
        }.should throw_symbol(:course_full, 20)
      end
    end
  end
end
