#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

# 
RSpec.describe Task do

  it_should_behave_like "sizeable"

  # 

  describe "initialization" do
    let(:task) { Task.new }

    it "does not have a new task as complete" do
      expect(task).not_to be_complete
    end

    it "allows us to complete a task" do
      task.mark_completed
      expect(task).to be_complete
    end

    #
    it "stubs with multiple return values" do
      task = Task.new
      allow(task).to receive(:size).and_return(1, 2)
      assert_equal(1, task.size)
      assert_equal(2, task.size)
      assert_equal(2, task.size)
    end
    #
  end

  #
  describe "velocity" do
    let(:task) { Task.new(size: 3) }

    it "does not count an incomplete task toward velocity" do
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end

    it "counts a recently completed task toward velocity" do
      task.mark_completed(1.day.ago) 
      expect(task).to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(3)
    end

    it "does not count a long-ago completed task toward velocity" do
      task.mark_completed(6.months.ago) 
      expect(task).not_to be_a_part_of_velocity
      expect(task.points_toward_velocity).to eq(0)
    end
  end
  # 

  #

  describe "order", aggregate_failures: true do
    let(:project) { create(:project, name: "Project") }
    let!(:first) { project.tasks.create!(project_order: 1) }
    let!(:second) { project.tasks.create!(project_order: 2) }
    let!(:third) { project.tasks.create!(project_order: 3) }

    it "can determine that a task is first or last" do
      expect(first).to be_first_in_project
      expect(first).not_to be_last_in_project
      expect(second).not_to be_first_in_project
      expect(second).not_to be_last_in_project
      expect(third).not_to be_first_in_project
      expect(third).to be_last_in_project
    end

    #
    it "knows neighbors" do
      expect(second.previous_task).to eq(first)
      expect(second.next_task).to eq(third)
      expect(first.previous_task).to be_nil
      expect(third.next_task).to be_nil
    end

    it "can move up" do
      second.move_up
      expect(first.reload.project_order).to eq(2)
      expect(second.reload.project_order).to eq(1)
    end

    it "can move down" do
      second.move_down
      expect(third.reload.project_order).to eq(2)
      expect(second.reload.project_order).to eq(3)
    end

    it "handles edge case moves up" do
      first.move_up
      expect(first.reload.project_order).to eq(1)
    end

    it "handles edge case moves down" do
      third.move_down
      expect(third.reload.project_order).to eq(3)
    end
    #
  end

  #

end
