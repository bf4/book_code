#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Notifier < ActionMailer::Base
  def multipart_alternative_rich(recipient, name, sent_at = Time.now)
    subject      "Something for everyone."
    recipients   recipient
    from         'barnam@chadfowler.com'
    sent_on      sent_at
    content_type "multipart/alternative" 

    part :content_type => "text/plain", 
      :body => render_message("multipart_alternative_plain", :name => name)

    part :content_type => "text/html", 
      :body => render_message("multipart_alternative_rich", :name => name)
  end
  def implicit_multipart(recipient, name, sent_at = Time.now)
    subject      "Something for everyone."
    recipients   recipient
    from         'barnam@chadfowler.com'
    sent_on      sent_at
    body(:name => name)
  end
end
