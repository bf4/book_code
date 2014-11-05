#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  def multipart_alternative_rich
    @greeting = "Hi"

    mail :to => "chad+rails3recipes@chadfowler.com"
  end
  
end
