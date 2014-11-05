#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
set -e
cp -R 00 01
cd 01

cat << 'EOG' >> Gemfile

group :test do
  gem 'cucumber-rails', '1.3.0'
  gem 'rspec-rails', '2.11.0'
  gem 'database_cleaner', '0.8.0'
end
EOG

bundle install
bundle exec rails generate cucumber:install

cat << 'EOF' > features/see_messages.feature
Feature: See Messages
  Scenario: See another user's messages
    Given there is a User
    And the User has posted the message "this is my message"
    When I visit the page for the User
    Then I should see "this is my message"
EOF

echo "--no-source" > build_options

../../../script/build-cukes
