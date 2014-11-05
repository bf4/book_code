#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require 'net/imap'
require 'openssl'

class MailPerson < ActionMailer::Base
  

  
  
  def welcome_message(user)
    from 'lunchedin@gmail.com'
    recipients user.email
    subject "Thank you for registering with our website"
    body :first_name => user.first_name, :last_name => user.last_name
  end
  
  
  #
  # The idea is to call it like MailPerson.deliver_signed(:welcome_message, user).
  # An even better aproach would be to replace method_missing with the additional directives
  #
  
  def self.deliver_signed(method, *vargs)
    message = send("create_#{method}", vargs.first)
    key = OpenSSL::PKey::RSA.new(
      File::read("#{RAILS_ROOT}/config/lunchedin.gmail.email.key"))
    cert = OpenSSL::X509::Certificate.new(
      File::read("#{RAILS_ROOT}/config/lunchedin.gmail.email.cer"))
    p7sig  = OpenSSL::PKCS7::sign(cert, key, message.encoded, [], 
      OpenSSL::PKCS7::DETACHED)
    smime = OpenSSL::PKCS7::write_smime(p7sig)
    
    
      def smime.encoded; self end
      def smime.from; TMail::Mail.parse(self).parts.first.from end
      def smime.destinations 
        TMail::Mail.parse(self).parts.first.destinations 
      end
      def smime.method_missing(*vargs); end
    self.deliver(smime)
  end
  

  # great info
  # http://blog.mondragon.cc/articles/2006/12/30/decoding-email-attachments-with-actionmailer-base-receive

  
  def self.check_mail
    imap = Net::IMAP.new('imap.gmail.com', 993, true)
    imap.login('lunchedin', 'lunchedin1')
    imap.select('INBOX')
    imap.search(['ALL']).each do |m|
      msg = imap.fetch(m,'RFC822')[0].attr['RFC822']
      receive(msg)
      imap.store(m, "+FLAGS", [:Deleted])
    end
    imap.expunge()
  end
  


  
  def receive(email)
    begin
      pkcs7 = OpenSSL::PKCS7::read_smime(email.port.to_s)
      store = OpenSSL::X509::Store.new
      ca = File::read("#{RAILS_ROOT}/config/email_ca.cer")
      store.add_cert(OpenSSL::X509::Certificate.new(ca))

      if pkcs7.verify([], store)
        id = email.parts.first.body.match(/\[(\d)\]/).captures.first
        elements = pkcs7.certificates.first.subject.to_a
        cert_email = elements.detect { |e| e.first == 'emailAddress' }
        parts = email.parts.first.body.split('--- lunchedin@gmail.com wrote:')
        body_text = parts.first
        venue = Venue.find(id)
        comment = Comment.new
        comment.user = User.find_by_email(cert_email[1])
        comment.subject = 'Well I thought...'
        comment.body = body_text
        venue.comments << comment
      end
    rescue OpenSSL::PKCS7::PKCS7Error
      logger.debug 'PKCS7 error'
    end
  end
  
  
  
  
  def venue_comment(event)
    from 'lunchedin@gmail.com'
    recipients event.hosted_by.email
    subject "Tell us what you think!"
    body :event => event
  end
  
end
