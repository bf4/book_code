#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
cp -R 10 11
cd 11
patch --no-backup-if-mismatch -p3 < ../11.diff

cat << 'EOF' > features/step_definitions/view_steps.rb
Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end
EOF

../../../script/build-cukes
