#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
class Notifier < ActionMailer::Base
  def contact(recipient)
    @recipient = recipient
	
    mail(to: @recipient, from: "john.doe@example.com") do |format|
      format.text
      format.html
    end
  end
end
