#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

describe ProjectsController do

  before(:each) do
    sign_in User.create!(email: "rspec@example.com", password: "password")
  end

  describe "#create" do
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "start something:2"}
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end

    it "creates a project with mocks" do
      fake_project = double(create: true)
      allow(CreatesProject).to receive(:new)
          .with(name: "Runway", task_string: "start something:2")
          .and_return(fake_project)
      post :create, project: {name: "Runway", tasks: "start something:2"}
      expect(CreatesProject).to have_received(:new)
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action)).not_to be_nil
    end

    it "fails gracefully" do
      allow_any_instance_of(Project).to receive(:save).and_return(false)
      expect { post :create, :project => {:name => 'Project Runway'} }
        .not_to change { Project.count }
    end
  end

end
