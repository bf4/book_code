#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
When /^I publish an article$/ do
  steps %{
    When I set the title to "First post!"
    When I set the body to "Hello world!"
    When I click the "Done" button
  }
end

# In our hypothetical wire protocol example, the following steps would
# be furnished by the wire server.

When /^I set the title to "First post!"$/ do
end

When /^I set the body to "Hello world!"$/ do
end

When /^I click the "Done" button$/ do
end
