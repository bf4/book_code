#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#recipe = Recipe.create!(:name => "Clam Nuggets", :body => "Bread, fry, dip in seaweed")
#recipe.ingredients.create!(:name => "Clam", :amount => "2 lbs")
#recipe.ingredients.create!(:name => "Flour", :amount => "1 sack")
#recipe.ingredients.create!(:name => "Liquified Seaweed", :amount => "16 oz")

Meeting.create!(
                 name: "Jazz and Donut Enthusiasts",
                 description: "Eat Donuts, Listen to jazz, wipe powdered sugar on black t-shirts",
                 starts_at: 2.days.from_now,
                 ends_at: 3.days.from_now
)
Meeting.create!(
                 name: "Fast Food Fashion Meetup",
                 description: "Discuss fast-food restaurant uniform fashion",
                 starts_at: 20.days.from_now,
                 ends_at: 21.days.from_now
)

