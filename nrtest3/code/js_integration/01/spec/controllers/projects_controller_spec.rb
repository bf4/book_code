#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe ProjectsController, type: :controller do

  describe "create" do
    it "calls the workflow with parameters" do
      workflow = instance_spy(CreatesProject, success?: true)
      allow(CreatesProject).to receive(:new).and_return(workflow)
      post :create,
        params: {project: {name: "Runway", tasks: "start something:2"}}
      expect(CreatesProject).to have_received(:new)
        .with(name: "Runway", task_string: "start something:2")
    end

  end

end
