#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'openid/consumer'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'

class SessionController < ApplicationController
  # We need to setup the storage of the OpenID Sessions

  skip_before_filter :check_authentication

  def index
    render :action => 'login'
  end

  def check_login
    username, password = params[:user][:username], params[:user][:password]
    if @authenticated_user = User.find_and_authenticate(username, password)
      session[:user_id] = @authenticated_user.id
      redirect_to user_path(@authenticated_user)
    else
      
      flash[:notice] = "the user #{params[:user][:username]}, "
      flash[:notice] << "was not found with the specified password"
      redirect_to :controller => 'session', :action => 'login'
      
    end
  end

  
  # We want to handle the client openid request
  
  
  def begin_openid
    identifier = params[:openid_identifier]
    openid_request = consumer.begin(identifier)
    
    
    return_to = url_for(:action => :complete_openid, :only_path => false)
    realm = url_for(:action => :index, :only_path => false)
    
    # Registry data extension
    
    
    sregreq = OpenID::SReg::Request.new
    # required registration fields
    sregreq.request_fields(['email', 'fullname', 'postcode'], true)
    openid_request.add_extension(sregreq)
    # We are hard coding this to keep the implementation simple.  This
    # could be provided as an option in the form.
    openid_request.return_to_args['did_sreg'] = 'y'
    
    # This if/else provides support for AJAX flow.  This is not a complete
    # implementation.
    
    if openid_request.send_redirect?(realm, return_to, params[:immediate])
      
      redirect_to openid_request.redirect_url(realm, return_to, params[:immediate])
      
    else
      render :text => openid_request.html_markup(realm, 
        return_to, params[:immediate], {'id' => 'openid_form'})
    end
    
  end
  

  
  
  # This implementation was strongly derived from the 
  # OpenID example included with the OpenID gem.
  def complete_openid
    current_url = url_for(:action => 'complete_openid', :only_path => false)
    parameters = params.reject{|k,v|request.path_parameters[k]}
    oidresp = consumer.complete(parameters, current_url)
    
    
    if oidresp.status == OpenID::Consumer::SUCCESS
      identifier = oidresp.identity_url
      if @authenticated_user = User.find_by_username(identifier)
        session[:user_id] = @authenticated_user.id
    
    
      else
        if params[:did_sreg]
          sreg_resp = OpenID::SReg::Response.from_success_response(oidresp)        
          if sreg_resp.empty?
            # This is where we would want to direct the user to a form where they 
            # could fill in their profile data.
            logger.debug "NO SREG DATA RETURNED"
            flash[:notice] = 'We are unable to setup
                              an account with the provided OpenID.'
          else
            @authenticated_user = User.create_from_openid_data(identifier, sreg_resp)
            session[:user_id] = @authenticated_user.id
          end
        end
      end
      redirect_to user_path(@authenticated_user)
    
    
    else
      redirect_to :action => 'index'
    end
  end
  
  

  def logout
    reset_session
  end

  
  def consumer
    @store = OpenID::Store::Filesystem.new("#{RAILS_ROOT}/tmp/openid")
    @consumer ||= consumer = OpenID::Consumer.new(session, @store)
  end
  
end
