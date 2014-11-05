#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class MailPersonTest < ActionMailer::TestCase
  tests MailPerson

  
  def test_create_signed_welcome_message
    message = MailPerson.create_welcome_message(users(:wally)) 
    
    # instantiate openssl objects
    key = OpenSSL::PKey::RSA.new(
      File::read("#{RAILS_ROOT}/config/lunchedin.gmail.email.key"))
    cert = OpenSSL::X509::Certificate.new(
      File::read("#{RAILS_ROOT}/config/lunchedin.gmail.email.cer"))
      
    # sign encoded message
    p7sig  = OpenSSL::PKCS7::sign(cert, key, message.encoded, [], 
      OpenSSL::PKCS7::DETACHED) 
    smime = OpenSSL::PKCS7::write_smime(p7sig, message.encoded)
    
    new_message = TMail::Mail.parse(smime)
    # assert_equal(new_message.encoded, smime) doesn't work!
    
      
    def smime.encoded; self end
    def smime.from; TMail::Mail.parse(self).parts.first.from end
    def smime.destinations; TMail::Mail.parse(self).parts.first.destinations end
  
    MailPerson.deliver(smime) 
    assert_equal ['lunchedin@gmail.com'], smime.from
    assert_equal ['wally@yahoo.com'], smime.destinations
  end
  
  
  
  def test_deliver_signed
    MailPerson.deliver_signed(:welcome_message, users(:wally))
    smime = OpenSSL::PKCS7::read_smime(ActionMailer::Base.deliveries.first)
    ca = File::read("#{RAILS_ROOT}/config/email_ca.cer")
    cacert = OpenSSL::X509::Certificate.new(ca)
    store = OpenSSL::X509::Store.new
    store.add_cert(cacert)
    assert smime.verify([], store)
  end
  
  
  
  def test_received_comment_success
    MailPerson.deliver_venue_comment(events(:one))
    reply = ActionMailer::Base.deliveries.first.create_reply
    reply.body = <<-BODY
The margaritas were great!
--- lunchedin@gmail.com wrote:

> Dear Wally Webcoder,
> 
> Thanks for using LunchedIn to organize your event!
> 
> Please respond to this email and tell us about Mi
> Cocina.
> 
> [1]
    BODY
        
    wally_cert = File::read('test/certs/wally.yahoo.com.cer')
    cert = OpenSSL::X509::Certificate.new(wally_cert)
    wally_key = File::read('test/certs/wally.yahoo.com.key')
    key = OpenSSL::PKey::RSA.new(File::read('test/certs/wally.yahoo.com.key'))
    p7sig  = OpenSSL::PKCS7::sign(cert, key, reply.encoded, [], OpenSSL::PKCS7::DETACHED)
    smime = OpenSSL::PKCS7::write_smime(p7sig)
    size_before = Comment.count
    MailPerson.receive(smime)
    assert_equal size_before + 1, Comment.count
  end
  
    
  
  def test_received_comment_invalid_signature
    MailPerson.deliver_venue_comment(events(:one))
    reply = ActionMailer::Base.deliveries.first.create_reply
    reply.body = <<-BODY
The margaritas were great!
--- lunchedin@gmail.com wrote:

> Dear Wally Webcoder,
> 
> Thanks for using LunchedIn to organize your event!
> 
> Please respond to this email and tell us about Mi
> Cocina.
> 
> [Mi Cocina=1]
        BODY

    size_before = Comment.count
    MailPerson.receive(reply.encoded)
    assert_equal size_before, Comment.count
  end
  
  
end
