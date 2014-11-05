#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @action = CreatesProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks] || "")
    success = @action.create
    if success
      redirect_to projects_path
    else
      @project = @action.project
      render :new
    end
  end

  #
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, notice: "'project was successfully updated.'"
    else
      render action: 'edit'
    end
  end
  #
end
