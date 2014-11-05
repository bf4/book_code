#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'
require 'timeout'

module SelectBasedTimeout
  CHUNK_SIZE = 1024 * 16

  def read_data(timeout = 5)
    begin
      read_nonblock(CHUNK_SIZE)
    rescue Errno::EAGAIN
      if IO.select([self], nil, nil, timeout)
        retry
      else
        raise Timeout::Error
      end
    end
  end

  def write_data(data, timeout)
    written = 0

    loop do
      written = write_nonblock(data)
      break if written == data.size

      data = data[written..-1]
    end
  end
end

