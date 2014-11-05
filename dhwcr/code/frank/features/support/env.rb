#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'frank-cucumber'
Frank::Cucumber::FrankHelper.use_shelley_from_now_on

Before do
  app_path = ENV['APP_BUNDLE_PATH'] || raise('APP_BUNDLE_PATH undefined')
  launch_app app_path
end
After do
  step 'I quit the simulator'
end
