#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
require 'rubygems'
require 'spec'

describe "sunset match examples" do
  predicate_matchers[:drive_at_night] = :can_drive_at_night?
  predicate_matchers[:be_able_to_drive_at_night] = :can_drive_at_night?
  
  class Candidate
    def can_drive_at_night?; true; end
  end
  
  it "should be able to drive at night" do
    candidate = Candidate.new
    candidate.should be_can_drive_at_night
    candidate.should be_able_to_drive_at_night
    candidate.should drive_at_night
  end
end
