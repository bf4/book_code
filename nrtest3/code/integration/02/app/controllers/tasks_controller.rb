#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class TasksController < ApplicationController
  before_action :load_task, only: %i[up down]

  def create
    @project = Project.find(params[:task][:project_id])
    @project.tasks.create(
      task_params.merge(project_order: @project.next_task_order))
    redirect_to(@project)
  end

  def up
    @task.move_up
    redirect_to(@task.project)
  end

  def down
    @task.move_down
    redirect_to(@task.project)
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :size)
  end
end
