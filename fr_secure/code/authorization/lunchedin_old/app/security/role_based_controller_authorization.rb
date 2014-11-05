#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
  
module RoleBasedControllerAuthorization

  def self.included(base)
    base.extend(AuthorizationClassMethods)
  end
  

  
  def authorization_filter
    user = User.find(:first, 
      :conditions => ["id = ?", session[:user_id]])
    
    action_name = request.parameters[:action].to_sym
    action_roles = self.class.access_list[action_name]
    
    if action_roles.nil?
      logger.error "You must provide a roles declaration\
        or add skip_before_filter :authorization_filter to\
        the beginning of #{self}."
      # We deliberately did not return any information to the user here.
      # This is considered a programmer error.  We could also raise an
      # Error or Exception here.  If we wanted to switch to a blacklist
      # version of the role based access control, this would allow the 
      # Action.  However, this violates two of our principles; Least 
      # Privilege, Whitelist
      redirect_to :controller => 'root', :action => 'index'
      return false
    elsif action_roles.include? user.role.name.to_sym
      return true
    else
      logger.info "#{user.user_name} (role: #{user.role.name}) attempted to access\
        #{self.class}##{action_name} without the proper permissions."
      flash[:notice] = "Not authorized!"
      redirect_to :controller => 'root', :action => 'index'
      return false
    end
  end
  
end


module AuthorizationClassMethods
  def self.extended(base)
    class <<base
      @access_list = {}
      attr_reader :access_list 
    end
  end
  
  def roles(*roles)
    @roles = roles 
  end
  
  def method_added(method)
    logger.debug "#{caller[0].inspect}"
    logger.debug "#{method.inspect}"
    @access_list[method] = @roles  
  end
end

