#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---

# Designers
# ---------

spade = Designer.create!(name: 'Sam Spade',
                         email: 'spade@artflowme.com',
                         password: 'testtest',
                         password_confirmation: 'testtest')


trowel = Designer.create!(name: 'Sam Trowel',
                        email: 'trowel@artflowme.com',
                        password: 'testtest',
                        password_confirmation: 'testtest')

# Client: RubyCentral
# -------------------
rc = Client.create!(name: 'Code Conference',
                    email: 'client+cc@artflowme.com',
                    password: 'testtest',
                    password_confirmation: 'testtest')
rc2011 = rc.campaigns.create!(name: 'Conference', cost: '150.00',
                              start_date: 1.month.ago,
                              end_date: 4.days.ago)
shirt = rc2011.projects.create!(name: 'Shirt', active: true)
# Seed creations
ProjectSeeder.run(shirt, 'rubyconf2011-shirt', spade)

last_shirt_creation = shirt.creations.last
10.times do |i|
  last_shirt_creation.comments.create(body: "Test", user: trowel)
end

# Client: Juniper Lane
# --------------------
jl = Client.create!(name: 'Juniper Lane',
                    email: 'admin@juniperlane.com',
                    password: 'testtest',
                    password_confirmation: 'testtest')

jlpromos = jl.campaigns.create!(name: 'Promotions', cost: '5280',
                                start_date: 1.day.ago,
                                end_date: 20.days.from_now)
posters = jlpromos.projects.create!(name: 'Show Posters')
postcard = jlpromos.projects.create!(name: 'Postcard')

ProjectSeeder.run(posters, 'jlpromos-posters', trowel)
ProjectSeeder.run(postcard, 'jlpromos-postcard', trowel)

jlsetme = jl.campaigns.create!(name: 'Set Me On Fire EP', cost: '3000',
                               start_date: 10.days.from_now,
                               end_date: 12.days.from_now)
setmecd = jlsetme.projects.create!(name: 'CD Layout')

ProjectSeeder.run(setmecd, 'jlsetme-setmecd', trowel)

jllftpb = jl.campaigns.create!(name: 'Live From The Phone Booth', cost: '4200.80')
lftpbcd = jllftpb.projects.create!(name: 'CD Layout')

ProjectSeeder.run(lftpbcd, 'jllftpb-lftpbcd', trowel)

# Client: Meticluous
# ------------------
met = Client.create!(name: 'Meticulous',
                     email: 'admin@meticulous.com',
                     password: 'testtest',
                     password_confirmation: 'testtest')

metweb = met.campaigns.create!(name: 'Meticulous Website', cost: '3400.75')
metsite = metweb.projects.create!(name: 'Site version 7')

ProjectSeeder.run(metsite, 'metweb-metsite', trowel)

metcard = met.campaigns.create!(name: 'Business Card', cost: '345.12')
johncard = metcard.projects.create!(name: "John's Business Card")

ProjectSeeder.run(johncard, 'metcard-johncard', trowel)
