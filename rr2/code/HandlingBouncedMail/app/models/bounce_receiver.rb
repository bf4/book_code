#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class BounceReceiver < ActionMailer::Base 
  class BouncedDelivery
    attr_accessor :status_info, :original_message_id
    def self.from_email(email)
      returning(bounce = self.new) do
        status_part = email.parts.detect do |part| 
          part.content_type == "message/delivery-status"
        end 
        statuses = status_part.body.split(/\n/)
        bounce.status_info =  statuses.inject({}) do |hash, line| 
          key, value = line.split(/:/)
          hash[key] = value.strip rescue nil
          hash
        end
        original_message_part = email.parts.detect do |part|
          part.content_type == "message/rfc822"
        end
        parsed_msg = TMail::Mail.parse(original_message_part.body) 
        bounce.original_message_id = parsed_msg.message_id 
      end                             
    end  
    def status
      case status_info['Status']
      when /^5/
        'Failure'
      when /^4/ 
        'Temporary Failure'
      when /^2/            
        'Success'
      end
    end
  end
  def receive(email)
    return unless email.content_type == "multipart/report"
    bounce = BouncedDelivery.from_email(email)
    msg    = Delivery.find_by_message_id(bounce.original_message_id)
    msg.update_attribute(:status, bounce.status)
  end
end
