#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'spnego'

class SpnegoNegotiater

  include R_spnego
  include GSSAPI
  def initialize
    @keytab_filename = "../gssapi_api/ruby4.keytab"
    krb_5_gss_register_acceptor_identity(@keytab_filename)
    service_name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG"  
    buffer = GssBufferDescStruct.new
    buffer.set_value_from_string(service_name)
    buffer.set_value_from_string(service_name)
    results = gss_import_name(buffer, NT_USER_NAME)
    gss_release_buffer buffer
    major_status, minor_status, opaque_name = results
    results = gss_acquire_cred(opaque_name, 0, NULL_OID_SET, GSS_C_ACCEPT)
    major, minor, creds, oid_set, usage = results
    @server_creds = creds
    puts "[#{self.class}] Initializing"
  end

  def self.get_error_type(value)
    case value
    when  SPNEGO_E_SUCCESS
      "Success"
    when SPNEGO_E_INVALID_PARAMETER
      "Invalid Parameter"
    when SPNEGO_E_OUT_OF_MEMORY
      "Out of Memory"
    else
      "Unknown"
    end
  end

  def self.process_server_token(token = "")
    i_result = R_SPNEGO::spnego_create_neg_token_targ(
      Spnego_mech_oid_Kerberos_V5, Spnego_negresult_NotUsed,
      token, token.length, nil, 0, nil )
  end

end

SpnegoNegotiater.new
