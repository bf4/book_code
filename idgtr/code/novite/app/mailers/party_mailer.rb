#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
class PartyMailer < ActionMailer::Base
  def invite(party, address)
    @party      = party
    @address    = address

    @subject    = "Invitation to #{@party.name}"
    @from       = 'no-reply@example.com'
    @recipients = address
    @sent_on    = Time.now
    @url        = party_url @party, :host => 'localhost:3000'
  end
end
