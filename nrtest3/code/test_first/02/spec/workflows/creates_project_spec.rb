#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe CreatesProject do

  describe "initialization" do
    it "creates a project given a name" do
      creator = CreatesProject.new(name: "Project Runway")
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe "task string parsing" do
    it "handles an empty string" do
      creator = CreatesProject.new(name: "Project Runway", task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end

    it "handles a single string" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with size " do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:3")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 3)
    end

    it "handles a single string with size zero" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:0")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with malformed size" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with negative size" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:-1")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles multiple tasks" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(2)
      expect(tasks).to match(
        [an_object_having_attributes(title: "Start Things", size: 3),
         an_object_having_attributes(title: "End Things", size: 2)])
    end

    it "attaches tasks to the project" do
      creator = CreatesProject.new(
        name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_a_new_record
    end
  end

end
