#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper.rb'

require 'date'

class TestTodo < Test::Unit::TestCase
    include Icalendar

    def test_todo_fields

        cal = Calendar.new

        t = cal.todo do
            summary      "Plan next vacations"
            description  "Let's have a break"
            percent      50
            seq          1
            add_category "TRAVEL"
            add_category "SPORTS"
        end

        calString = cal.to_ical

        assert_match(/PERCENT-COMPLETE:50/, calString)
        assert_match(/DESCRIPTION:Let's have a break/, calString)
        assert_match(/CATEGORIES:TRAVEL,SPORTS/, calString)
        assert_match(/SEQUENCE:1/, calString)

    end
end


