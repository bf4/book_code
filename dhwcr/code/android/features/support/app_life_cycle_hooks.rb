#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
require 'calabash-android/management/adb'
require 'calabash-android/operations'
include Calabash::Android::Operations

AfterConfiguration do |config|
  wake_up unless config.dry_run?
end

Before do |scenario|
  start_test_server_in_background
end

After do
    shutdown_test_server
end
