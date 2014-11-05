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

Contact.create!(:name => "Chad Fowler",
                :city => "New Orleans",
                :state => "LA",
                :postal_code => "70112",
                :country => "USA")
Contact.create!(:name => "Donald Shimoda",
                :city => "Oak Park",
                :state => "IL",
                :postal_code => "60301",
                :country => "USA")
Contact.create!(:name => "Toru Okada",
                :city => "Tokyo",
                :postal_code => "5023934",
                :country => "Japan")
