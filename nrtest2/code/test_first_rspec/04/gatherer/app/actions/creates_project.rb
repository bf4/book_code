#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class CreatesProject
  attr_accessor :name, :task_string, :project

  def initialize(name: "", task_string: "")
    @name= name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name)
    project.tasks = convert_string_to_tasks
    project
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |task_string|
      title, size = task_string.split(":")
      size = 1 if (size.blank? || size.to_i.zero?)
      Task.new(title: title, size: size)
    end
  end

  def create
    build
    project.save
  end
end
