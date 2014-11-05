#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'gssapi_api'
class SessionController < ApplicationController

  skip_before_filter :check_authentication
  
  def index
    render :action => 'login'
  end
  
  
  
  include GSSAPI
  def check_login
    @ctx = nil
    keytab_filename = "#{RAILS_ROOT}/config/monster.keytab"
    @server_creds = acquire_service_cred(nil, keytab_filename)
  
  
    if auth_header = request.headers['HTTP_AUTHORIZATION']
      logger.debug { "first 10: [#{auth_header[0..9]}]" }
      token = auth_header[10..-1]
  
  
      recv_string = Base64.decode64(token)
      recv_token = GssBufferDescStruct.new
      recv_token.set_value_from_byte_array(recv_string,recv_string.size)
      gss_session = 
        accept_sec_context(:creds => @server_creds, 
                           :token => recv_token)
  
  
      case gss_session.major
      when GSSAPI::GSS_S_CONTINUE_NEEDED
        render :text => "not quite there.", :status => 401
      when GSSAPI::GSS_S_COMPLETE
        d_results = gss_display_name(gss_session.principal)
        username = d_results[2].get_value_as_string
        # render(:text => "Authenticated. User: #{username}",
        #   :status => 200)
        @authenticated_user = User.create_or_find_from_kerb_princ(username)
        session[:user_id] = @authenticated_user.id
        redirect_to user_path(@authenticated_user)
      else
        render(:text => "Access Denied: #{gss_session.major}", 
               :status => 401)
      end
    else 
      render(:text => "\nHeaders:\n#{request.headers.to_a.join("<br/>")}", 
             :status => 401)
      
      logger.debug { "Negotiate initiated" }
      response.headers['WWW-Authenticate'] = 'Negotiate'
    end
  end
  
  
  
  def logout
    reset_session
  end
end
