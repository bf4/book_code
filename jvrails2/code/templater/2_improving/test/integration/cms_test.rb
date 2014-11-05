#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require 'test_helper'

class CmsTest < ActiveSupport::IntegrationCase
  test "can access any page in SqlTemplate" do
    visit "/sql_templates"
    click_link "New Sql template"

    fill_in "Body",    with: "My first CMS template"
    fill_in "Path",    with: "about"
    fill_in "Format",  with: "html"
    fill_in "Locale",  with: "en"
    fill_in "Handler", with: "erb"

    click_button "Create Sql template"
    assert_match "Sql template was successfully created.", page.body

    visit "/cms/about"
    assert_match "My first CMS template", page.body
  end
end