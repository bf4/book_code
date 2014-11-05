#---
# Excerpted from "Working with Unix Processes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jsunix for more book information.
#---
module Spyglass
  class Master
    include Logging

    def initialize(connection, socket)
      @connection, @socket = connection, socket
      @worker_pids = []
      
      # The Master shares this pipe with each of its worker processes. It
      # passes the writable end down to each spawned worker while it listens
      # on the readable end. Each worker will write to the pipe each time
      # it accepts a new connection. If The Master doesn't get anything on
      # the pipe before `Config.timeout` elapses then it kills its workers
      # and exits. 
      @readable_pipe, @writable_pipe = IO.pipe
    end

    # This method starts the Master. It enters an infinite loop where it creates
    # processes to handle web requests and ensures that they stay active. It takes
    # a connection as an argument from the Lookout instance. A Master will only 
    # be started when a connection is received by the Lookout.
    def start
      trap_signals

      load_app
      out "Loaded the app"

      # The first worker we spawn has to handle the connection that was already
      # passed to us.
      spawn_worker(@connection)
      # The Master can now close its handle on the client socket since the
      # forked worker also got a handle on the same socket. Since this one
      # is now closed it's up to the Worker process to close its handle when
      # it's done. At that point the client connection will perceive that
      # it's been closed on their end.
      @connection.close

      # We spawn the rest of the workers.
      (Config.workers - 1).times { spawn_worker }
      out "Spawned #{Config.workers} workers. Babysitting now..."

      loop do
        if timed_out?(IO.select([@readable_pipe], nil, nil, Config.timeout))
          out "Timed out after #{Config.timeout} s. Exiting."
          
          kill_workers(:QUIT)          
          exit 
        else
          # Clear the data on the pipe so it doesn't appear to be readable
          # next time around the loop.
          @readable_pipe.read_nonblock 1
        end
      end
    end

    def timed_out?(select_result)
      !select_result
    end

    def spawn_worker(connection = nil)
      @worker_pids << fork { Worker.new(@socket, @app, @writable_pipe, connection).start }
    end

    def trap_signals
      # The QUIT signal triggers a graceful shutdown. The master shuts down
      # immediately and lets each worker finish the request they are currently
      # processing.
      trap(:QUIT) do
        verbose "Received QUIT"

        kill_workers(:QUIT)
        exit
      end

      trap(:CHLD) do
        dead_worker = Process.wait
        @worker_pids.delete(dead_worker)

        @worker_pids.each do |wpid|
          begin 
            dead_worker = Process.waitpid(wpid, Process::WNOHANG)
            @worker_pids.delete(dead_worker)
          rescue Errno::ECHILD
          end
        end

        spawn_worker
      end
    end
    
    def kill_workers(sig)
      @worker_pids.each do |wpid|
        Process.kill(sig, wpid)
      end
    end

    def load_app
      @app, options = Rack::Builder.parse_file(Config.config_ru_path)
    end
  end
end

