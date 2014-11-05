#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require 'rails_helper'

describe Project do

  #
  describe "with a new project" do
    let(:project) { Project.new }
    let(:task) { Task.new }

    it "knows that a project with no tasks is done" do
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is done" do
      project.tasks << task
      expect(project).not_to be_done
    end
  #

    describe "with a project that has one task" do
      before(:each) do
        project.tasks << Task.new
      end

      it "knows a project is only done if all its tests are done" do
        expect(project.done?).to be_falsy
        project.tasks.first.mark_completed
        expect(project.done?).to be_truthy
      end
    end

    describe "with stubs" do
      it "can stub an instance and return a value" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name).and_return("Fred")
        expect(project.name).to eq("Fred")
      end

      it "can mock an instance and expect a value" do
        project = Project.new(name: "Project Greenlight")
        expect(project).to receive(:name).and_return("Fred")
        project.name
      end

      it "can spy on an instance" do
        project = Project.new(name: "Project Greenlight")
        allow(project).to receive(:name).and_return("Fred")
        project.name
        expect(project).to have_received(:name)
      end
    end
  end

  describe "with a custom matcher" do
    let(:project) { Project.new }
    let(:completed_task) { Task.new(size: 3, completed_at: 1.hour.ago) }
    let(:incompleted_task) { Task.new(size: 2) }

    it "uses the custom matcher" do
      project.tasks = [completed_task, incompleted_task]
      expect(project).to have_size(5)
      expect(project).to have_size(2).for_incomplete_tasks_only
    end
  end

end
