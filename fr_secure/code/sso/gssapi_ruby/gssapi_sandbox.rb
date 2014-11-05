#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# class GSSName
#   
# end
# 
# class GSSCredential
#   
# end
# 
# class GSSContext
#   
# end
require 'GSSAPI'

class GSSServerAuthenticationSession
  # TODO: Make these Read only as necessary
  attr_accessor :service_name
  attr_accessor :context
  attr_accessor :last_token_recieved
  attr_accessor :last_token_sent
  attr_accessor :server_creds
  attr_accessor :client_creds
  attr_accessor :client_principal
  attr_accessor :minor_status
  attr_accessor :major_status
  
  #TODO: Read these from a yaml file
  OPTS = {
    :service_name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG",
    :keytab_file  = "/Users/draphael/Desktop/ruby2.keytab"
  }
  
  def initialize(opts = {})
    OPTS.merge(opts)
    # stNameBuffer => 
    p_minor_status         = SWIG::TYPE_p_int.allocate
    p_returned_server_name = SWIG::TYPE_p_gss_desc_struct.allocate
    
    major_status = GSSAPI::gss_import_name( 
                            p_minor_status, 
                            st_name_buffer, 
                            GSSAPI::GSS_C_NT_USER_NAME, 
                            p_returned_server_name );
    
    if iMajorStatus != GSSAPI::GSS_S_COMPLETE
      # TODO Wrap display errorr messages
      log.error("Error importing service name.");
      raise Error
    end
  end
  
  def negotiate_incoming(message)
    
  end
  
  def accept_client_message(message)
  # iMajorStatus = gss_accept_sec_context(
  #                         &iMinorStatus,              => :minor_status
  #                         &ctx,                       => :context
  #                         outServiceCredentials,      => :server_creds
  #                         &recvToken,                 => :last_token_recieved
  #                         GSS_C_NO_CHANNEL_BINDINGS,  => don't need this for ruby
  #                         &sender,                    => :client_principal
  #                         NULL,                       => 
  #                         &sendToken,                 => :last_token_sent
  #                         NULL,                       => NULL
  #                         NULL,                       => NULL
  #                         &delegCreds);               => NULL
  end
  
  def send_message_to_client(message)
    
  end
  
  def tear_down
    # Perhaps do some cleanup here?
  end
  
  
end