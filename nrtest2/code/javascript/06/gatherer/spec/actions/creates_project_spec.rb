#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
require "rails_helper"

describe CreatesProject do

  it "creates a project given a name" do
    creator = CreatesProject.new(name: "Project Runway")
    creator.build
    expect(creator.project.name).to eq("Project Runway")
  end

  #
  describe "task string parsing" do
    let(:creator) { CreatesProject.new(name: "Test", task_string: task_string) }
    let(:tasks) { creator.convert_string_to_tasks }

    describe "with an empty string" do
      let(:task_string) { "" }
      specify { expect(tasks.size).to eq(0) }
    end

    describe "with a single string" do
      let(:task_string) { "Start things" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.map(&:title)).to eq(["Start things"]) }
      specify { expect(tasks.map(&:size)).to eq([1]) }
    end


    describe "with a single string and a size" do
      let(:task_string) { "Start things:3" }
      specify { expect(tasks.size).to eq(1) }
      specify { expect(tasks.map(&:title)).to eq(["Start things"]) }
      specify { expect(tasks.map(&:size)).to eq([3]) }
    end

    describe "with multiple tasks" do
      let(:task_string) { "Start things:3\nEnd things:2" }
      specify { expect(tasks.size).to eq(2) }
      specify { expect(tasks.map(&:title)).to eq(["Start things", "End things"]) }
      specify { expect(tasks.map(&:size)).to eq([3, 2]) }
    end

    describe "attaching tasks to the project" do
      let(:task_string) { "Start things:3\nEnd things:2" }
      it "saves the project and tasks" do
        creator.create
        expect(creator.project.tasks.size).to eq(2)
        expect(creator.project).not_to be_a_new_record
      end
    end

  end
  #

  #
  it "adds users to the project" do
    user = User.new
    creator = CreatesProject.new(name: "Project Runway",
        users: [user])
    creator.build
    expect(creator.project.users).to eq([user])
  end
  #

end
