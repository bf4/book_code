#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + "/GSSAPI")

module GSSAPI
  
  NT_USER_NAME = nt_user_name
  NULL_OID_SET = null_oid_set
  
  
  class GSSSession
    attr_accessor :ctx
    attr_accessor :token
    attr_accessor :major
    attr_accessor :minor
    attr_accessor :creds
    attr_accessor :results
    attr_accessor :principal
    attr_accessor :name
    attr_accessor :oid
    attr_accessor :oid_set
  end
  
    
  
  def init_sec_context(args={})
    args.merge!(args)
    results = gss_init_sec_context(
                  args[:creds],
                  args[:ctx],  
                  args[:opaque_name],
                  args[:mech], 
                  args[:flags] ||= 
                    GSS_C_MUTUAL_FLAG | GSS_C_REPLAY_FLAG | GSS_C_DELEG_FLAG,
                  args[:time_req] ||= 0,
                  args[:bindings],
                  args[:token_from_server]
                  )                  
    session = GSSSession.new
    session.major = results[0]
    session.minor = results[1]
    session.ctx = results[2]
    session.token = results[4]
    session.results = results
    session
  end
  
  
  
  def accept_sec_context(args={})
    args.merge!(args)
    results = gss_accept_sec_context( 
                  args[:ctx], 
                  args[:creds], 
                  args[:token], 
                  args[:bindings]
                  )

    session = GSSSession.new
    session.major = results[0]
    session.minor = results[1]
    session.ctx =   results[2]
    session.principal = results[3]
    session.token = results[5]
    session.creds = results[8]
    session.results = results
    session
  end
  
  
  
  def display_name(opaque_name)
    results = gss_display_name(opaque_name)
    session = GSSSession.new
    session.major = results[0]
    session.minor = results[1]
    session.token = results[2]
    session
  end
  
  
  
  def print_results(results, _name="UNDEFINED")
    puts "\n\n"
    puts "#{_name} #{results.length} results"
    print_errors(results[0],results[1])
    results.each do |r|
      puts "#{r} -> #{r.class}"
    end
  end
  
  
  
  def import_name(buffer, name_type)
    results = gss_import_name(buffer, name_type) 
    major_status, minor_status, opaque_name = results
    major, minor, creds, oid_set, usage = results
    session = GSSSession.new
    session.results = results
    session.major = results[0]
    session.minor = results[1]
    session.name  = results[2]
    session
  end
  
  
  
  def g_wrap_message(ctx, buffer)
    results       = gss_wrap(ctx, 1, 0, buffer)
    session       = GSSSession.new
    session.results = results
    session.major = results[0]
    session.minor = results[1]
    session.token = results[3]
    session
  end
  
  
  
  def g_unwrap_message(ctx, buffer)
    results       = gss_unwrap(ctx, buffer)
    session       = GSSSession.new
    session.results = results
    session.major = results[0]
    session.minor = results[1]
    session.token = results[2]
    session
  end
  
  
  
  def acquire_service_cred(service_name, keytab_filename)
    krb_5_gss_register_acceptor_identity(keytab_filename)
    buffer = GssBufferDescStruct.new
    buffer.set_value_from_string(service_name)
    results = gss_import_name(buffer, NT_USER_NAME) 
    major_status, minor_status, opaque_name = results
    gss_release_buffer buffer
    results = gss_acquire_cred(opaque_name, 0, NULL_OID_SET, GSS_C_ACCEPT)
    major, minor, creds, oid_set, usage = results
    creds
  end
  
end