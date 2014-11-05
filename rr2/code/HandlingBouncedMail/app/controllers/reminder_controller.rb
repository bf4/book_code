#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class ReminderController < ApplicationController
  def deliver
    mail = Reminder.deliver_reminder(params[:recipient], params[:text])
    Delivery.create(:message_id => mail.message_id, :recipient => params[:recipient],
                    :content => params[:text],      :status => 'Sent')
    render :text => "Message id #{mail.message_id} sent."                   
  end
end
