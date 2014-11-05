#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
user = User.create!(:name => "Bill")
user.roles << viewers = Role.create!(:name => "Viewer")

author = User.create!(:name => "Chad")
user.roles << authors = Role.create!(:name => "Author")

create = Right.create!(:resource => "recipes", :operation => "CREATE")
read = Right.create!(:resource => "recipes", :operation => "READ")
update = Right.create!(:resource => "recipes", :operation => "UPDATE")
delete = Right.create!(:resource => "recipes", :operation => "DELETE")

viewers.rights << read

authors.rights << create
authors.rights << read
authors.rights << update
authors.rights << delete
