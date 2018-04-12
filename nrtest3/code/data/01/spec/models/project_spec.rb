#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
require "rails_helper"

RSpec.describe Project do

  it_should_behave_like "sizeable"

  describe "completion" do
    #
    describe "without a task" do
      let(:project) { FactoryBot.build_stubbed(:project) }
      it "considers a project with no tasks to be done" do
        expect(project).to be_done
      end

      it "properly estimates a blank project" do
        expect(project.completed_velocity).to eq(0)
        expect(project.current_rate).to eq(0)
        expect(project.projected_days_remaining).to be_nan
        expect(project).not_to be_on_schedule
      end
    end

    describe "with a task" do
      let(:project) { FactoryBot.build_stubbed(:project, tasks: [task]) }
      let(:task) { FactoryBot.build_stubbed(:task) }

      it "knows that a project with an incomplete task is not done" do
        expect(project).not_to be_done
      end

      it "marks a project done if its tasks are done" do
        task.mark_completed
        expect(project).to be_done
      end
    end
    #
  end

  #
  describe "estimates" do
    let(:project) { FactoryBot.build_stubbed(:project,
      tasks: [newly_done, old_done, small_not_done, large_not_done]) }
    let(:newly_done) { FactoryBot.build_stubbed(:task,
      size: 3, completed_at: 1.day.ago) }
    let(:old_done) { FactoryBot.build_stubbed(:task,
      size: 2, completed_at: 6.months.ago) }
    let(:small_not_done) { FactoryBot.build_stubbed(:task, size: 1) }
    let(:large_not_done) { FactoryBot.build_stubbed(:task, size: 4) }

    it "can calculate total size" do
      expect(project).to be_of_size(10)
      expect(project).not_to be_of_size(5)
    end

    it "can calculate remaining size" do
      expect(project).to be_of_size(5).for_incomplete_tasks_only
    end
    #

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7) 
    end

    it "knows its projected days remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is not on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
    end

    it "knows if it is on schedule" do
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end
  end

end
