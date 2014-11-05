#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
if RUBY_VERSION < "1.9"
  module Process
    def self.daemon(nochdir = nil, noclose = nil)
      exit if fork                     # Parent exits, child continues.
      Process.setsid                   # Become session leader.
      exit if fork                     # Zap session leader. See [1].

      unless nochdir
        Dir.chdir "/"                  # Release old working directory.
      end

      File.umask 0000                  # Ensure sensible umask. Adjust as needed.

      unless noclose
        STDIN.reopen "/dev/null"       # Free file descriptors and
        STDOUT.reopen "/dev/null", "a" # point them somewhere sensible.
        STDERR.reopen '/dev/null', 'a'
      end

      trap("TERM") { exit }

      return 0
    end
  end
end
