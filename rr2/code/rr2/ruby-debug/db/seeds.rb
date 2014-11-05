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
Reminder.create!(title: "Give the dog his medicine",
                 starts_on: 1.day.from_now,
                 expires_on: 3.days.from_now)
Reminder.create!(title: "Walk the dogs",
                 starts_on: 2.days.ago,
                 expires_on: 1.day.ago)
Reminder.create!(title: "Feed the dogs",
                 starts_on: Date.today,
                 expires_on: 1.year.from_now)
