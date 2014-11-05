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
require 'digest'
require 'base64'

class GssServer
  DEFAULT_BUFFER_SIZE = 2048
  DEBUG = false
  
  attr_accessor :ctx
  module Tokens
    KNOCK_KNOCK    = "knock knock\n"
    SRV_REQ_CREDS  = "credentials\n"
    INVALID_TOKEN  = "I don't understand your request\n"
    CLIENT_ACK     = "OK\n"
    ACCESS_GRANTED = "Access Granted\n"
    ACCESS_DENIED  = "Access Denied\n"
    SECRET_REQUEST = "Secret Request\n"  
    OK_T           = "OK\n"
    HUSH_HUSH      = "shhhhh...don't tell anyone\n"
    NO_HUSH_HUSH   = "it's no secret\n"
    T_SECRET       = 2
    T_NEGO         = 1
    T_PLAIN        = 0
  end
  
  module TokenMechanisms
    include GSSAPI
    include Tokens
    
    def send_msg(gss_token, socket)
      srv_str = gss_token.get_value_as_byte_array
      token_string = Base64.encode64(srv_str)
      puts "[#{self.class}] Sending #{token_string.size} bytes" if self.class::DEBUG
      send_message(token_string, socket)
      gss_release_buffer gss_token
    end
    
    def recv_msg(socket)  
      recv_string_b64 = read_message(socket)
      puts "[#{self.class}] Received #{recv_string_b64.size} bytes" if self.class::DEBUG

      recv_string = Base64.decode64(recv_string_b64)
      recv_token = GssBufferDescStruct.new
      recv_token.set_value_from_byte_array(recv_string,recv_string.size)
      recv_token
    end

    def send_message(msg, socket)
      len = [msg.size].pack('N')
      socket.write(len)
      socket.write(msg)
    end

    def read_message(socket)
      len = socket.read(4)
      msg = socket.read(len.unpack('N').to_s.to_i)
      msg
    end
    
    def tell_secret(msg, socket)
      buffer_to_encrypt = GssBufferDescStruct.new
      buffer_to_encrypt.set_value_from_byte_array(msg.clone, msg.size)
      session = g_wrap_message(@ctx, buffer_to_encrypt)

      encrypted_buffer = session.token
      send_msg(encrypted_buffer, socket)
      # gss_release_buffer buffer_to_encrypt
    end
    
    def read_secret(socket)
      recv_token = recv_msg(socket)
      unencrypted_buffer = g_unwrap_message(@ctx, recv_token).token
      secret = unencrypted_buffer.get_value_as_byte_array.clone
      gss_release_buffer unencrypted_buffer
      secret
    end
  end
  
  include Socket::Constants
  include Tokens
  include TokenMechanisms
  include GSSAPI
  
  def initialize
    @keytab_filename = "ruby4.keytab"
    krb_5_gss_register_acceptor_identity(@keytab_filename)    
    service_name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG"  
    @secret_info = "Winning lotto: 1 2 4 11 21 9 8"
  
    buffer = GssBufferDescStruct.new
    buffer.set_value_from_string(service_name)
    results = gss_import_name(buffer, NT_USER_NAME) 
    major_status, minor_status, opaque_name = results

    #We don't need the buffer anymore.
    gss_release_buffer buffer
    
    results = gss_acquire_cred(opaque_name, 0, NULL_OID_SET, GSS_C_ACCEPT)
    major, minor, creds, oid_set, usage = results
    @server_creds = creds
    
    puts "[#{self.class}] Initializing"
    
    server = TCPServer.new("127.0.0.1", 5000)
    while(session = server.accept)
      
      hello = read_message(session)
          
      if(hello == KNOCK_KNOCK)
        puts "[#{self.class}] Received KNOCK_KNOCK" if DEBUG
        # Challenge the client
        puts "[#{self.class}] Sending SRV_REQ_CREDS" if DEBUG
        
        send_message(SRV_REQ_CREDS, session)
        msg = read_message(session)
        
        if CLIENT_ACK == msg
          puts "[#{self.class}] Received CLIENT_ACK" if DEBUG
          
          send_message(service_name,session)
          
          puts "[#{self.class}] Sent service name #{service_name}" if DEBUG
          if process_gss_requests(session)
            puts "[#{self.class}] Auth success" if DEBUG
            req = read_message(session)
            if req == SECRET_REQUEST
              puts "[#{self.class}] Client requests the secret" if DEBUG
              # Without crypto -> send_message(@secret_info,session)
              tell_secret(@secret_info, session)
              puts "[#{self.class}] Secret sent"
            end            
          else
            puts "Auth failure!!"
            send_message(ACCESS_DENIED,session)
          end
        end
      else
        puts "This is not a client that speaks our language!!!"
        send_message(INVALID_TOKEN,session)
      end
      session.close
    end
  end
  
  def process_gss_requests(session)
    results = []
    authenticated = false
  
    major_status = -5
    @ctx = nil
    client_princ = nil
    begin
      recv_token = recv_msg(session)
      gss_session = 
        accept_sec_context(:ctx   => @ctx, 
                           :creds => @server_creds, 
                           :token => recv_token)
      @ctx = gss_session.ctx
      msg = gss_session.token.get_value_as_byte_array      
      d_results = gss_display_name(gss_session.principal)
      client_princ = d_results[2].get_value_as_string
      puts "[#{self.class}] User requesting authentication: #{d_results[2].get_value_as_string}"
      if(msg)
        send_msg(gss_session.token, session)
      end
      
      major_status = gss_session.major
    end while major_status == GSSAPI::GSS_S_CONTINUE_NEEDED
    if major_status == GSSAPI::GSS_S_COMPLETE
      authenticated = true
    else
      puts "[#{self.class}] Failure: #{major_status}"
      print_results(gss_session.results, self.class.to_s) if DEBUG
    end
    authenticated
  end

  def self.run
    GssServer.new
  end
  
end

