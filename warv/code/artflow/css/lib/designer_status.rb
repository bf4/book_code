#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class DesignerStatus
  
  def initialize(designer)
    @designer = designer
  end
  
end

class DesignerStatus

  def active_projects_count
    active_projects.count
  end

  def pending_approvals_count
    active_creations.pending_approval.count
  end

  def approved_count
    active_creations.approved.count
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

  private

  def active_projects
    @designer.projects.active
  end

  def active_creations
    @designer.creations.active
  end
  
end
 
class DesignerStatus
  
  def initialize(designer, options = {})
    @designer = designer
    @options = options
  end

  def expanded?
    @options[:expanded]
  end
  
  # The rest of the class...
  
end


class DesignerStatus

  def initialize(designer, template, options = {})
    @designer = designer
    @template = template
    @options = options
  end
  
end

class DesignerStatus

  def to_s
    @template.render partial: 'designers/status', object: self
  end
  
end




