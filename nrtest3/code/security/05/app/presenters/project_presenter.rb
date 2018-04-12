#---
# Excerpted from "Rails 5 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrtest3 for more book information.
#---
class ProjectPresenter < SimpleDelegator
  def self.from_project_list(*projects)
    projects.flatten.map { |project| ProjectPresenter.new(project) }
  end

  def initialize(project)
    super
  end

  def name_with_status
    dom_class = on_schedule? ? "on_schedule" : "behind_schedule"
    "<span class='#{dom_class}'>#{name}</span>"
  end
end
