#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
class ExternalDependancyExample

  def initialize(db, network)
    @db = db
    @network = network
  end

  def send(key)
    data = @db.load(key)
    @network.transmit(data)
  end
  
  def receive(key)
    data = @network.receive
    @db.store(key, data)
  end
  
end