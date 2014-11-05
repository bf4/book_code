#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
require 'test_helper'

class CreationSummaryTest < ActiveSupport::TestCase

  def setup
    @creation = Factory(:creation)
    @client = @creation.client
    @designer = @creation.designer
    @admin = Factory(:admin)
  end
  
end

class CreationSummaryTest < ActiveSupport::TestCase
  test "an admin sees data including the estimate" do
    summary = CreationSummary.new(@creation, @admin)
    fields = [:campaign, :client, :designer,
              :hours, :name, :project, :revision, :stage,
              :estimate]
    assert_serializes fields, summary
  end
end

class CreationSummaryTest < ActiveSupport::TestCase

  def assert_serializes(fields, summary)
    assert_equal(fields.sort, summary.data.keys.sort,
                 "Serialization fields do not match")
  end
  
end

class CreationSummaryTest < ActiveSupport::TestCase
  test "a designer sees the standard data" do
    summary = CreationSummary.new(@creation, @designer)
    fields = [:campaign, :client, :designer,
              :hours, :name, :project, :revision, :stage]
    assert_serializes fields, summary    
  end
end


class CreationSummaryTest < ActiveSupport::TestCase
  test "a client only sees the sanitized data" do
    summary = CreationSummary.new(@creation, @client)
    fields = [:campaign, :designer,
              :name, :project, :revision, :stage]
    assert_serializes fields, summary    
  end
end
