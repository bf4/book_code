#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'test_helper'

<% module_namespacing do -%>
class <%= class_name %>Test < ActionMailer::TestCase
<% actions.each do |action| -%>
  test "<%= action %>" do
    mail = <%= class_name %>.<%= action %>
    assert_equal <%= action.to_s.humanize.inspect %>, mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

<% end -%>
<% if actions.blank? -%>
  # test "the truth" do
  #   assert true
  # end
<% end -%>
end
<% end -%>
