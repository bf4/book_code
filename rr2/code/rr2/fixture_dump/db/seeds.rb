#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
chad = Person.create(:name => "Chad")
kelly = Person.create(:name => "Kelly")
james = Person.create(:name => "James")

hindi_club = Club.create(:name => "Hindi Study Group")
snow_boarders = Club.create(:name => "Snowboarding Newbies")

chad.clubs.concat [hindi_club, snow_boarders]
kelly.clubs.concat [hindi_club, snow_boarders]
james.clubs.concat [snow_boarders]

[chad, kelly, james].each {|person| person.save}