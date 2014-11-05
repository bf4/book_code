#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
User.create!(:name => "Chad")
['Kelly Fowler',
  'Mike Clark',
  'Dave Thomas',
  'Mark Gardner',
  'Rich Kilmer',
  'Anthony Burns'].each do |name|
    Contact.create!(:name => name)
  end
  
  
['Blah blah blah foo bar', 'I ate some pizza', 'Travel sucks', 'The threat level is orange'].each do  |body|
  StatusUpdate.create!(:body => body, :title => "this is a status update")
end