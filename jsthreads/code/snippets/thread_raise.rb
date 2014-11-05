#---
# Excerpted from "Working with Ruby Threads",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsthreads for more book information.
#---
$cleaned_up = false
 
t = Thread.new do
  begin
    # nada
  ensure
    sleep
    $cleaned_up = true
  end
end

nil until t.status == 'sleep'
# At this point, the thread should be sleeping
# inside the ensure block. Now raise an exception 
# inside the thread.
t.raise 'hell'

# Joining with the thread will cause the exception
# to be re-raised here.
begin
  t.join
rescue
end
 
# This value is false because the ensure block
# was aborted when Thread#raise was called. This
# breaks the contract that ensure blocks provide.
puts $cleaned_up #=> false

