#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
namespace :logs do
  desc "Tail the Rails log for the current stage"
  task :tail, :roles => :app do
    stream "tail -f #{current_path}/log/#{stage}.log"
  end
end
