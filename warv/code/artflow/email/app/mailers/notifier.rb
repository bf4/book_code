#---
# Excerpted from "The Rails View",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/warv for more book information.
#---
class Notifier < ActionMailer::Base
  default :from => 'Art Flow <artflow@artflowme.com>'
  def creation_added(creation)
    @creation = creation
    @campaign = creation.project.campaign
    mail to: "test@artflowme.com",
         subject: "Creation Added"
  end
end
