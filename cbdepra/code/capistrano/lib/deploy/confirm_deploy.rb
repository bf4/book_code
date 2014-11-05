#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
namespace :deploy do
  desc "Make sure the user really wants to deploy"
  task :confirm do 
    if Capistrano::CLI.ui.ask("Are you sure you want to deploy?") == "yes"
      puts "OK, here goes!"
    else
      puts "Exiting"
      exit
    end
  end
end
