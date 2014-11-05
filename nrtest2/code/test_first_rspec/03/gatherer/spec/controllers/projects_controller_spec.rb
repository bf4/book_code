#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "POST create" do
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start something:2"} 
      expect(response).to redirect_to(projects_path) 
      expect(assigns(:action).project.name).to eq("Runway") 
    end
  end

end
