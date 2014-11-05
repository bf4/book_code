#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
Factory.define :designer do |x|
  x.sequence(:email) { |n| "designer#{n}@artflowme.com" } 
  x.password 'testtest'
end

Factory.define :project do |x|
  x.sequence(:name) { |n| "Project #{n}" }
  x.association :campaign
  x.active true
end

Factory.define :campaign do |x|
  x.sequence(:name) { |n| "Campaign #{n}" }
end

Factory.define :creation do |x|
  x.sequence(:name) { |n| "Creation #{n}" }
  x.association :project
  x.association :designer
  x.stage 'initial'
  x.revision 1
  x.description "This is a description"
end

Factory.define :admin do |x|
  x.sequence(:email) { |n| "admin#{n}@artflowme.com" } 
  x.password 'testtest'
end
