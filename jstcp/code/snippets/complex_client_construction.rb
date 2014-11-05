#---
# Excerpted from "Working with TCP Sockets",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jstcp for more book information.
#---
require 'socket'

# We build an Addrinfo object with the remote address. 
remote_address = Addrinfo.tcp('www.ruby-lang.org', 80)

# Then tell it to connect from a specific local port on the local host.
remote_address.connect_from("0.0.0.0", 4649) do |connection|
  connection.write "GET /"
  connection.close
end

