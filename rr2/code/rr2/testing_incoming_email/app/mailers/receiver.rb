#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Receiver < ActionMailer::Base
  default from: "from@example.com"
  def receive(email)
    MailMessage.create(:subject => email.subject, :body    => email.body.to_s,
                :sender  => email.from,    :rating  => 0)
  end
  def receive(email)
    rating = 0
    if([email.subject, email.body].any?{|string| string =~ /opportunity/i})
      rating += 1
    end
    MailMessage.create(:subject => email.subject, :body    => email.body.to_s,
                :sender  => email.from,    :rating  => rating)
  end
  def receive(email)
    rating = 0
    if([email.subject, email.body].any?{|string| string =~ /opportunity/i})
      rating += 1
    end
	
    if email.has_attachments?
      email.attachments.each do |attachment|
        rating += 1 if attachment.original_filename =~ /zip$/i
      end
    end
    MailMessage.create(:subject => email.subject, :body => email.body.to_s,
                :sender  => email.from,    :rating  => rating)
  end
end
