#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class CreationSummary

  delegate :to_json, :to => :data
  
  def initialize(creation, user)
    @creation = creation
    @user = user
  end

  def data
    case @user
    when Admin
      data_with_estimate
    when Designer
      standard_data
    else
      sanitized_data
    end
  end
  
end

class CreationSummary

  def standard_data
    {
      campaign: @creation.campaign.name,
      client: @creation.client.name,
      designer: @creation.designer.name,
      hours: @creation.hours,
      name: @creation.name,
      project: @creation.project.name,
      revision: @creation.revision,
      stage: @creation.name
    }
  end

  def sanitized_data
    standard_data.reject do |k, v|
      [:hours, :client].include?(k)
    end
  end

  def data_with_estimate
    estimate_data = {
      hours: @creation.estimate.hours,
      rate: @creation.estimate.rate,
      total: @creation.estimate.total
    }
    standard_data.merge(estimate: estimate_data)
  end

end
