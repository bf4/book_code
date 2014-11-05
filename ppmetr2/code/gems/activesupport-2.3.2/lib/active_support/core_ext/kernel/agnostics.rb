#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # Makes backticks behave (somewhat more) similarly on all platforms.
  # On win32 `nonexistent_command` raises Errno::ENOENT; on Unix, the
  # spawned shell prints a message to stderr and sets $?.  We emulate
  # Unix on the former but not the latter.
  def `(command) #:nodoc:
    super
  rescue Errno::ENOENT => e
    STDERR.puts "#$0: #{e}"
  end
end