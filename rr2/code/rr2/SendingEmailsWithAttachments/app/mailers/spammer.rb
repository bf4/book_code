#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Spammer < ActionMailer::Base
  default :from => "from@example.com"
  def spam_with_attachment(name, email, file)
    @name = name
    attachments[file.original_filename] = file.read
    mail :to => email, :subject => "Have a Can of Spam!"
  end
end
class Spammer
  def spam_with_attachment_inline(name, email, file)
    @name = name
    attachments.inline['photo.png'] = file.read
    mail :to => email, :subject => "Have a Can of Spam!"
  end
end
