#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class DesignerStatus

  def initialize(designer, template, options = {})
    @designer = designer
    @template = template
    @options = options
  end

  def expanded?
    @options[:expanded]
  end

  def active_projects_count
    active_projects.count
  end

  def awaiting_approvals_count
    creations.with_status(:awaiting_approval).count
  end

  def approved_count
    creations.with_status(:approved).count
  end

  def active_hours
    active_projects.total_hours
  end
  
  def hours_per_project
    active_projects.inject({}) do |memo, project|
      memo[project] = project.total_hours
      memo
    end
  end

  def to_s
    @template.render partial: 'designers/status', object: self
  end

  private

  def active_projects
    @designer.projects.active
  end

  def creations
    @designer.creations
  end
  
end




