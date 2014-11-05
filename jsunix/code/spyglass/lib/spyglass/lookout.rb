#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
module Spyglass
  class Lookout
    include Singleton, Logging

    # This method is the main entry point for the Lookout class. It takes
    # a socket object.
    def start(socket)
      trap_signals

      # The Lookout doesn't know anything about the app itself, so there's
      # no app related setup to do here.
      loop do
        # Accepts a new connection on our socket. This class won't actually
        # do anything interesting with this connection, it will pass it down
        # to the `Master` class created below to do the actual request handling.
        conn = socket.accept
        out "Received incoming connection"

        # In this block the Lookout forks a new process and invokes a Master,
        # passing along the socket it received and the connection it accepted
        # above.
        @master_pid = fork do
          master = Master.new(conn, socket)
          master.start
        end

        # The Lookout can now close its handle on the client socket. This doesn't
        # translate to the socket being closed on the clients end because the
        # forked Master process also has a handle on the same socket. Since this
        # handle is now cleaned up it's up to the Master process to ensure that
        # its handle gets cleaned up.
        conn.close
        # Now this process blocks until the Master process exits. The Master process
        # will only exit once traffic is slow enough that it has reached its timeout
        # without receiving any new connections.
        Process.waitpid(@master_pid)
        
        # The interaction of fork(2)/waitpid(2) above deserve some explanation.
        
        # ### Why fork(2)? Why not just spin up the Master?
        # The whole point of the Lookout process is to be very lean. The only resource
        # that it initializes is the listening socket for the server. It doesn't load
        # any of your application into memory, so its resource footprint is very small.
        
        # The reason that it does a fork(2) before invoking the Master is because once
        # the Master times out we want the Lookout process to remain lean when accepting
        # the next connection. 
        
        # If it were to load the application code without forking 
        # then there would be no (simple) way for it to later unload the application code.
        
        # By doing a fork(2), then waiting for the Master process to exit, that guarantees
        # that all resources (notably memory usage) that were in use by the Master process
        # will be reclaimed by the kernel. 
        
        # ### Who knows what your app will demand!
        # While handling requests your app may require lots of memory. Containing this in a
        # child process, and exiting that process, is the easiest way to ensure that memory
        # bloat isn't shared with our simple parent process.
        
        # This allows our Lookout process will to go back around
        # the loop with nothing more than it started with, just a listening socket.
        
        # The fork(2)/waitpid(2) approach requires little code to implement, and pushes 
        # responsibility down to the kernel to track resource usage and nicely clean up
        # the Master process when it's finished.
      end
    end

    def trap_signals
      [:INT, :QUIT].each do |sig|
        trap(sig) { 
          begin
            Process.kill(sig, @master_pid) if @master_pid
          rescue Errno::ESRCH
          end
          exit 
        }
      end
    end
  end
end

