#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'faker'
50.times do |n|
  Person.create!(:name => [Faker::Name.first_name, Faker::Name.last_name].join(" "), :age => rand(50))
end
people = Person.all

20.times do |n|

  post = Post.create!(:title => Faker::Company.bs)
  rand(5).times do
    post.ratings.create(:person => people.shuffle.first, :post => post, :value => rand(5))
  end
end

100.times do
  Donation.create!(:amount => rand(1000), :created_at => rand(600).days.ago)
end
Donation.all.each do |d|
  d.update_attribute(:created_at, rand(1600).days.ago)
end

