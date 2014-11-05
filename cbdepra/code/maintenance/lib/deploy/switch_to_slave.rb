#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
namespace :deploy do
  desc "Switch application to slave server"
  task :switch_to_slave do
    standby_file = "#{current_path}/config/standby.database.yml"
    run "cp #{standby_file} #{current_path}/config/database.yml"
    deploy.restart
  end
end

