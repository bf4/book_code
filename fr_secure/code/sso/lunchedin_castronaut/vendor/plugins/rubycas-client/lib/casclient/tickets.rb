#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module CASClient
  # Represents a CAS service ticket.
  class ServiceTicket
    attr_reader :ticket, :service, :renew
    attr_accessor :response
    
    def initialize(ticket, service, renew = false)
      @ticket = ticket
      @service = service
      @renew = renew
    end
    
    def is_valid?
      response.is_success?
    end
    
    def has_been_validated?
      not response.nil?
    end
  end
  
  # Represents a CAS proxy ticket.
  class ProxyTicket < ServiceTicket
  end
  
  class ProxyGrantingTicket
    attr_reader :ticket, :iou
    
    def initialize(ticket, iou)
      @ticket = ticket
      @iou = iou
    end
    
    def to_s
      ticket
    end
  end
end