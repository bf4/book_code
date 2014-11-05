#---
# Excerpted from "Deploying Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cbdepra for more book information.
#---
namespace :diagnostics do
  desc "Display free memory"
  task :memory_usage do
    mem = capture("free -m | grep Mem").squeeze.split(' ')[1..-1]
    total, used, free, shared, buffers, cached = mem

    puts "Memory on #{role} (in MBs)"
    puts "Total: #{total}"
    puts "Used: #{used}"
    puts "Free: #{free}"
    puts "Shared: #{shared}"
    puts "Buffers: #{buffers}"
    puts "Cached: #{cached}"
  end
end

