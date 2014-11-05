#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
When /^I go to the creation's page$/ do
  visit creation_path(@creation)
end

Then /^there should be (\d+) comments?$/ do |number|
  assert_equal Integer(number), all(:css, '#comments li').size
end

Then /^the comment form should be visible$/ do
  assert has_selector?(:css, 'form#new_comment')
end

When /^I enter a comment and submit it$/ do
  fill_in('comment_body', with: 'Test Comment')
  click_button('Add Comment')
end

