#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class AuditSweeper < ActionController::Caching::Sweeper
  observe Person  
  def after_destroy(record)
    log(record, "DESTROY")
  end

  def after_update(record)
    log(record, "UPDATE")
  end

  def after_create(record)
    log(record, "CREATE")
  end

  def log(record, event, user = controller.session[:user])
    AuditTrail.create(:record_id => record.id, :record_type => record.type.name, 
                      :event => event, :user_id => user)
  end
end
