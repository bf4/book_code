#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
require 'drb/drb'
require 'rinda/rinda'
require 'my_uri'

class Service
  def initialize
    @pending_requests = {}
    @seq_no = 1
    @server_id = $$
    DRb.start_service
    drb_connection = DRbObject.new(nil, ::MY_URI)
    @ts = Rinda::TupleSpaceProxy.new(drb_connection)
    Thread.start { handle_responses }
  end

  def run
    loop { process }
  end

  def request(*args, &block)
    msg = [ @server_id, @seq_no ].concat(args)
    @pending_requests[@seq_no] = block
    @seq_no += 1
    @ts.write(msg)
  end

  def respond(request, value)
    puts "Responde #{value}"
    @ts.write([request[0], request[1], :answer, value])
  end

  def handle_responses
    loop do
      response = @ts.take([@server_id, nil, :answer, nil])
      seq_no = response[1]
      pending = @pending_requests[seq_no]
      fail("Invalid sequence number #{seq_no}") unless pending
      def response.answer
        self[3]
      end
      pending.call(response)
    end
  end
end


