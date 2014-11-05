#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Spammer < ActionMailer::Base
  def spam_with_attachment(name, email, file)
    @subject    = 'Have a Can of Spam!'
    @body       = {:name => name}
    @recipients = email
    @from       = 'spam@chadfowler.com'
    unless file.blank?
      attachment :body => file.read, :filename => file.original_filename 
    end
  end
end
