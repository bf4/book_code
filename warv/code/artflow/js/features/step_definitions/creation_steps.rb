#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
Given 'a creation' do

  # Create client record
  client = Client.create!(name: 'TestClient',
                          email: 'client@test.artflowme.com',
                          password: 'testtest',
                          password_confirmation: 'testtest')
  campaign = client.campaigns.create!(name: 'National 1')
  project = campaign.projects.create!(name: 'Pamphlet')
  # Add current user to project
  project.designers << @user
  # Add creation
  sample = File.open('test/fixtures/creation.png')
  @creation = project.creations.create!(name: "Logo",
                                        designer: @user,
                                        description: "Test",
                                        file: sample)
end
