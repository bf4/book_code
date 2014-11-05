#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class CreatePeopleAndClubsTables < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column :name, :string
    end
    
    create_table :clubs do |t|
      t.column :name, :string
    end
    
    create_table :clubs_people, :id => false do |t|
      t.column :person_id, :integer
      t.column :club_id, :integer
    end
    
    chad = Person.create(:name => "Chad")
    kelly = Person.create(:name => "Kelly")
    james = Person.create(:name => "James")
    
    hindi_club = Club.create(:name => "Hindi Study Group")
    snow_boarders = Club.create(:name => "Snowboarding Newbies")
    
    chad.clubs.concat [hindi_club, snow_boarders]
    kelly.clubs.concat [hindi_club, snow_boarders]
    james.clubs.concat [snow_boarders]
    [chad, kelly, james].each {|person| person.save}
  end

  def self.down
    drop_table :people
    drop_table :clubs
    drop_table :clubs_people
  end
end
