#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class Roster
  def initialize(id, database)
    @id = id
    @database = database
  end

  def register(student)
    @database.count('Roster', :course_id => @id)
    @database.add(student)
  end
  
  def register(student)
    @database.count('Roster', :course_id => @id)
    @database.begin
    @database.add(student)
    @database.commit
  end
end

describe Roster do
  it "asks database for count before adding" do
    database = double()
    student  = double()
    database.should_receive(:count).with('Roster', :course_id => 37).ordered
    database.should_receive(:add).with(student).ordered
    roster = Roster.new(37, database)
    roster.register(student)
  end
end
