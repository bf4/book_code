#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
When /^I bookmark "(.*?)"$/ do |url|
  performAction 'enter_text_into_numbered_field', url, 1
  performAction 'click_on_view_by_id', 'addUrl'
end

Then /^I should see the following bookmarks:$/ do |expected|
  performAction 'wait_for_text', 'Enter a URL to bookmark', 5
  result = performAction 'get_list_item_text'
  actual = result['bonusInformation']
  actual.each_with_index do | row_data, index |
    row_data = JSON.parse row_data
    actual[index] = row_data
  end
  expected.map_headers! 'url' => 'text1'
  expected.diff! actual
end
