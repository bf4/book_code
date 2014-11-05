#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require 'test_helper'
require 'fixtures/sample_mail'

class ComplianceTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def setup
    @model = SampleMail.new
  end
end

class ComplianceTest < ActiveSupport::TestCase
  test "model_name exposes singular and human name" do
    assert_equal "sample_mail", @model.class.model_name.singular
    assert_equal "Sample mail", @model.class.model_name.human
  end

  test "model_name.human uses I18n" do
    begin
      I18n.backend.store_translations :en,
        activemodel: { models: { sample_mail: "My Sample Mail" } }

      assert_equal "My Sample Mail", @model.class.model_name.human
    ensure
      I18n.reload!
    end
  end
end
