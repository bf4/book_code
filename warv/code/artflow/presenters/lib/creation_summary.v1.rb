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

