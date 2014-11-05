#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require "service_manager"

ServiceManager.define_service "transaction_processor" do |s|
  s.start_cmd = "ruby lib/transaction_processor.rb"
  s.loaded_cue = /ready/
  s.cwd = Dir.pwd
  s.pid_file = 'transaction_processor.pid'
end
