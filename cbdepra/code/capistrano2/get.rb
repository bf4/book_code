#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
desc "Download the production log file"
task :get_log do
  get "#{current_path}/log/production.log", \
    "#{Time.now.strftime("%Y%m%d%H%M")}.production.log"
end

