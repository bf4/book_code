#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'gssapi_api'
require 'socket'
require 'server'
require 'digest'
require 'base64'
require 'pp'

class GssClient
  include GssServer::Tokens
  include GssServer::TokenMechanisms
  include GSSAPI
  
  attr_accessor :ctx
  DEBUG = true
  
  
  
  def initialize
    puts "[#{self.class}] Initializing"
    if preauthenticate
      socket = TCPSocket.new("127.0.0.1", 5000)
      send_message(KNOCK_KNOCK, socket)
      recv = read_message(socket)
  
      puts "[#{self.class}] Received: #{recv}" if DEBUG
  
      authenticated = false
      if(recv == SRV_REQ_CREDS)
        send_message(CLIENT_ACK,socket)
        authenticated = process_gss_requests(socket)
      end
  
  
      if authenticated
        puts "[#{self.class}] Getting secret" if DEBUG
        send_message(SECRET_REQUEST, socket)
        secret = read_secret(socket)
        puts "[#{self.class}] Secret: #{secret}"
      else
        msg = read_message(socket)
        puts "[#{self.class}] #{msg}" 
      end
      socket.close
    else
      puts "Unable to collect Valid Credentials."  
    end
  end
  
  
  
  
  def preauthenticate
    # Attempt to use logged in user account
    results = gss_acquire_cred(nil, 0, NULL_OID_SET, GSS_C_INITIATE)
    
    unless(results[0] == GSSAPI::GSS_S_COMPLETE &&
                         results[1] == GSSAPI::GSS_S_COMPLETE)
      puts "Please enter username:"
      client_name = gets.chomp
      buffer = GssBufferDescStruct.new
      buffer.set_value_from_string(client_name)
      results = gss_import_name(buffer, NT_USER_NAME)
      major_status, minor_status, client_opaque_name = results
      gss_release_buffer buffer
      results = gss_acquire_cred(client_opaque_name, 0, 
                                 NULL_OID_SET, GSS_C_INITIATE)
    end
    
    if(results[0] == GSSAPI::GSS_S_COMPLETE && 
      results[1] == GSSAPI::GSS_S_COMPLETE)
      true
    else
      false
    end
  end
  
  
  
  
  def process_gss_requests(socket)
    service_name = read_message(socket)
    puts "[#{self.class}] Service name: #{service_name.inspect}"
  
  
    buffer = GssBufferDescStruct.new
    buffer.set_value_from_string(service_name.chomp)
    results = gss_import_name(buffer, NT_USER_NAME) 
    major_status, minor_status, opaque_name = results    
    gss_release_buffer buffer
  
  
    recv_token = nil
    gss_session = nil
    authenticated = false
    begin
      puts "[#{self.class}] init_sec_context =>" if DEBUG
      gss_session = init_sec_context({ 
          :opaque_name => opaque_name, 
          :ctx => self.ctx,
          :token_from_server => recv_token })
      major_status  = gss_session.major
      # We have to use 'self' here to ensure that the variable is 
      # scoped to the object instance level and not the block level.
      self.ctx      = gss_session.ctx
      srv_str       = gss_session.token.get_value_as_byte_array      
      if srv_str && major_status == GSSAPI::GSS_S_CONTINUE_NEEDED
        puts "[#{self.class}] #{self.class} Sending token" if DEBUG
        send_msg(gss_session.token, socket)
        puts "[#{self.class}] receiving token" if DEBUG
        recv_token = recv_msg(socket)
      else
        puts "[#{self.class}] no more tokens to process" if DEBUG
      end
      
    end while(major_status == GSSAPI::GSS_S_CONTINUE_NEEDED)
  
  
    if(major_status == GSSAPI::GSS_S_COMPLETE)
      puts "[#{self.class}] Client successfully authenticated!" if DEBUG
      puts "[#{self.class}] Major Status: #{major_status}" if DEBUG
      authenticated = true
    else
      puts "[#{self.class}] Client failed"
      print_results(gss_session.results, self.class.to_s) if DEBUG
      send_message("Failed\n.",socket)
    end
    authenticated
  end
  
  
end


GssClient.new
